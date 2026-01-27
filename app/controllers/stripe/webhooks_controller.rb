module Stripe
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :require_authentication
    skip_before_action :set_current_cart

    def create
      # From debugging some gnarly issues with request parsing
      # >> Keep this in case it happens again!
      unless request.content_type&.include?('application/json')
        Rails.logger.error "\e[101;1mWebhook received with wrong content type: #{request.content_type}\e[0m"
        return head :unsupported_media_type
      end

      payload = request.raw_post
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']

      event = ::Stripe::Webhook.construct_event(
        payload,
        sig_header,
        webhook_signing_secret
      )

      handle_stripe_event(event)
      head :ok
    rescue JSON::ParserError => e
      # Invalid payload
      Rails.logger.error "\e[101;1mJSON Parser Error -- invalid payload\e[0m"
      return head :bad_request
    rescue ::Stripe::SignatureVerificationError => e
      # Invalid signature
      Rails.logger.error "\e[101;1mStripe Sig Verification Error - invalid signature\e[0m"
      return head :bad_request
    end

    private

    def webhook_signing_secret
      # ENV for local dev (Stripe CLI), credentials for production
      ENV.fetch('STRIPE_WEBHOOK_SECRET') { Rails.application.credentials.dig(:stripe, :webhook_secret) }
    end

    ### Stripe Event Router ###
    def handle_stripe_event(event)
      check_for_duplicate_events(event)
      checkout_session = event.data.object

      case event.type
      when 'checkout.session.async_payment_succeeded'
        handle_async_payment_succeeded(checkout_session)
      when 'checkout.session.async_payment_failed'
        handle_async_payment_failed(checkout_session)
      when 'refund.created', 'refund.updated'
        refund = event.data.object
        Rails.logger.info '---Refund Created and/or Updated---'
        Rails.logger.info "-0-0-0- Refund: #{refund.id} -0-0-0-"

        handle_refunded_order(refund) if refund.status == 'succeeded'
      when /price\..*/
        Rails.cache.delete('stripe_products')
        Rails.logger.info "--------> PRICE CHANGED: #{event.inspect}"
      when /product\..*/
        Rails.cache.delete('stripe_products')

        product = event.data.object
        previous_attributes = event.data.previous_attributes

        AlgoliaService::PostProductUpdate.call(product:, previous_attributes:)
      ###########################################################################
      # -------------------------------------------
      ### THE EVENTS BELOW SHOULD BE HANDLED AD HOC BY WEBMASTER/PRODUCT OWNER ###
      # -------------------------------------------
      # If any patterns emerge over time (ie, if you have a lot of failed
      # refunds), it will be worth your time to develop a more sophisticated
      # solution to keep yourself from having to solve these problems ad hoc.
      #
      # But otherwise, this section of the case statement should allow you to
      # monitor & handle these events as needed with a low-traffic site.
      # -------------------------------------------
      # ie, "if refund status is requires_action, failed, canceled, or pending"
      ###########################################################################
      when /refund\.(?!created|updated).*/
        Rails.logger.info "---Refund Event: #{event.type}---"
        handle_unexpected_event(event)
      else
        Rails.logger.info "---Unhandled event type: #{event.type}---"
      end
      # -------------------------------------------
    end

    def check_for_duplicate_events(event)
      event_already_in_cache = Rails.cache.read("stripe_event:#{event.id}")

      if event_already_in_cache
        Rails.logger.info '!=!=! This event has already been cached & routed !=!=!'
        Rails.logger.info '--- ignoring ---'
        AdminMailer.event_notification(event)
        return
      elsif !event_already_in_cache
        Rails.cache.write("stripe_event:#{event.id}", DateTime.now, expires_in: 7.days)
        Rails.logger.info "#-#-# Event #{event.id} has been cached. #-#-#"
      end
    end

    def handle_async_payment_succeeded(checkout_session)
      payment_intent, local_checkout_record, cart = set_up_transaction_info(checkout_session)

      if payment_intent.status == 'succeeded'
        # Check if we've already processed this payment (idempotency check)
        if local_checkout_record.status == 'awaiting shipment'
          Rails.logger.info "🔄 Async payment already processed for checkout session #{checkout_session.id} - skipping"
          return
        end

        PaymentHandlingService::HandleSuccessfulPayment.call(
          checkout_session: checkout_session,
          cart: cart
        )
      else
        Rails.logger.warn "\e[101;1m---Unexpected Payment Intent Status for PI# #{payment_intent.id} -- #{payment_intent.status}\e[0m"
        AdminMailer.payment_issue_notification(checkout_session, payment_intent)
      end
    end

    def handle_async_payment_failed(checkout_session)
      payment_intent, local_checkout_record, cart = set_up_transaction_info(checkout_session)

      local_checkout_record.update(status: 'payment failed')

      Rails.logger.error "\e[101;1m -----x----- Payment Failed for Checkout Session # #{checkout_session.id}\e[0m"
      Rails.logger.error "\e[101;1m #{checkout_session.inspect}\e[0m"

      AdminMailer.payment_issue_notification(checkout_session, payment_intent)
    end

    def handle_refunded_order(refund)
      Rails.logger.info "---Refund Succeeded: #{refund.id}---"

      order = Order.find_by(payment_intent_id: refund.payment_intent)
      checkout = Checkout.find_by(payment_intent_id: refund.payment_intent)

      order.update(status: 'refunded', refunded_on: Time.now.to_s)
      checkout.update(status: 'refunded', refunded_on: Time.now.to_s)

      OrderMailer.refunded(order).deliver_later
    end

    def handle_unexpected_event(event)
      Rails.logger.warn "\e[101;1m[!] ->->-> Unexpected Event:\e[0m"
      Rails.logger.warn "\e[101;1m#{event.inspect}\e[0m"

      AdminMailer.event_notification(event)
    end

    def set_up_transaction_info(checkout_session)
      payment_intent = ::Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)
      local_checkout_record = Checkout.find_by(stripe_checkout_session_id: checkout_session.id)
      cart = Cart.find(local_checkout_record.cart_id)

      [payment_intent, local_checkout_record, cart]
    end
  end
end
