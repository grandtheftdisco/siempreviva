class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_authentication
  skip_before_action :set_current_cart

    def create
      # from debugging some gnarly issues with request parsing
      unless request.content_type&.include?('application/json')
        Rails.logger.debug "Webhook received with wrong content type: #{request.content_type}"
        return head :unsupported_media_type
      end

    payload = request.raw_post
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    
    event = Stripe::Webhook.construct_event(
      payload,
      sig_header,
      Rails.application.credentials.dig(:stripe, :webhook_secret)
    )

    handle_stripe_event(event)
    head :ok

  rescue JSON::ParserError => editing
    # invalid payload
    Rails.logger.debug "JSON Parser Error -- invalid payload"
    return head :bad_request
  rescue Stripe::SignatureVerificationError => e
    # invalid signature
    Rails.logger.debug "Stripe Sig Verification Error - invalid signature"
    return head :bad_request
  end

  private

  ### Stripe Event Router ###
  def handle_stripe_event(event)
    check_for_duplicate_events(event)
    checkout_session = event.data.object
    
    case event.type
    when 'checkout.session.completed'
      handle_checkout_session_completed(checkout_session)
    when 'checkout.session.async_payment_succeeded'
      handle_async_payment_succeeded(checkout_session)
    when 'checkout.session.async_payment_failed'
      handle_async_payment_failed(checkout_session)
    when 'refund.created', 'refund.updated'
      refund = event.data.object
      Rails.logger.info "---Refund Created and/or Updated---"
      Rails.logger.info "-0-0-0- Refund: #{refund.id} -0-0-0-"
      
      if refund.status == 'succeeded'
        handle_refunded_order(refund)
      end
    when /product\..*/, /price\..*/
      Rails.cache.delete("stripe_products")
      Rails.logger.info "--------> PRODUCT OR PRICE CHANGED: #{event.inspect}"
    # -------------------------------------------
    ### THE EVENTS BELOW SHOULD BE HANDLED AD HOC BY DEV/PRODUCT OWNER ###
    # -------------------------------------------
    # If any patterns emerge over time (ie, if you have a lot of failed 
    # refunds), it will be worth your time to develop a more sophisticated
    # solution to keep yourself from having to solve these problems ad hoc.

    # But otherwise, this section of the case statement should allow you to
    # monitor & handle these events as needed with a low-traffic site.
    # -------------------------------------------
    # ie, "if refund status is requires_action, failed, canceled, or pending"
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
      Rails.logger.info "!=!=! This event has already been cached & routed !=!=!"
      Rails.logger.info "--- ignoring ---"
      AdminMailer.event_notification(event)
      return
    elsif !event_already_in_cache
      Rails.cache.write("stripe_event:#{event.id}", DateTime.now, expires_in: 7.days)
      Rails.logger.info "#-#-# Event #{event.id} has been cached. #-#-#"
    end
  end

  def handle_checkout_session_completed(checkout_session)
    payment_intent, local_checkout_record, cart = set_up_transaction_info(checkout_session)

    if checkout_session.payment_status == 'paid' || checkout_session.payment_status == 'no_payment_required'
      begin
        PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session: checkout_session,
                                                             cart: cart)
      rescue => e
        Rails.logger.error "Error in PaymentHandlingService: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
      end
    elsif checkout_session.payment_status == 'unpaid'
      case payment_intent.status
      when 'succeeded'
        Rails.logger.info "---Payment Intent #{payment_intent.id} complete!---"
        # rare
        # HandleSuccessfulPayment
      when 'processing'
        Rails.logger.info "---Payment Intent #{payment_intent.id} for Checkout Session #{checkout_session.id} PROCESSING...---"

        # order.update(status: 'payment processing')

        local_checkout_record.update(status: 'payment_processing')
      when 'requires_payment_method', 'requires_action', 'requires_confirmation'
        Rails.logger.warn "---Payment Issue! #{payment_intent.id}has status of #{payment_intent.status}---"

        # order.update(status: payment_intent.status)

        local_checkout_record.update(status: payment_intent.status)
        AdminMailer.payment_issue_notification(checkout_session, payment_intent)
      else
        Rails.logger.warn "---Unexpected Payment Intent Status---"
        Rails.logger.warn "---Payment Intent #{payment_intent.id} has a status of #{payment_intent.status}---"
        
        AdminMailer.payment_issue_notification(checkout_session, payment_intent)
      end
    end
  end

  def handle_async_payment_succeeded(checkout_session)
    payment_intent, local_checkout_record, cart = set_up_transaction_info(checkout_session)

    if payment_intent.status == 'succeeded'
      PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session: checkout_session,
                                                           cart: cart)
    else
      Rails.logger.warn "---Unexpected Payment Intent Status for PI# #{payment_intent.id} -- #{payment_intent.status}"
      AdminMailer.payment_issue_notification(checkout_session, payment_intent)
    end
  end

  def handle_async_payment_failed(checkout_session)
    payment_intent, local_checkout_record, cart = set_up_transaction_info(checkout_session)

    local_checkout_record.update(status: 'payment failed')
    
    Rails.logger.error "\e[101;1m -----x----- Payment Failed for Checkout Session # #{checkout_session.id}\e[0"
    Rails.logger.error "\e[101;1m #{checkout_session.inspect}\e[0"

    AdminMailer.payment_issue_notification(checkout_session, payment_intent)
  end

  def handle_refunded_order(refund)
    Rails.logger.info "---Refund Succeeded: #{refund.id}---"
        
    order = Order.find_by(payment_intent_id: refund.payment_intent)
    checkout = Checkout.find_by(payment_intent_id: refund.payment_intent)

    order.update(status: "refunded", refunded_on: "#{Time.now}")
    checkout.update(status: "refunded", refunded_on: "#{Time.now}")

    OrderMailer.refunded(order).deliver_later
  end

  def handle_unexpected_event(event)
    Rails.logger.warn "[!] ->->-> Unexpected Event:"
    Rails.logger.warn "#{event.inspect}"

    AdminMailer.event_notification(event)
  end

  def set_up_transaction_info(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)
    local_checkout_record = Checkout.find_by(stripe_checkout_session_id: checkout_session.id)
    cart = Cart.find(local_checkout_record.cart_id)

    [payment_intent, local_checkout_record, cart]
  end
end