class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_authentication
  skip_before_action :set_current_cart
    def create
      Rails.logger.debug "Content-Type: #{request.content_type}"
      unless request.content_type&.include?('application/json')
        Rails.logger.debug "Webhook received with wrong content type: #{request.content_type}"
        return head :unsupported_media_type
      end
    payload = request.raw_post
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    # FIXME - may not need this line anymore - removing so logs are easier to read while debugging something else 
    # Rails.logger.debug "Raw payload: #{request.raw_post}"
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
    if checkout_session.payment_status == 'paid' || checkout_session.payment_status == 'no_payment_required'
      Rails.logger.info "\e[0;95m---> Webhooks Ctrlr ---Checkout Session #{checkout_session.id} complete!---\e[0m"
      # CheckoutsController will call PaymentHandlingService since it has access
      # to session data; this controller does NOT.
    elsif checkout_session.payment_status == 'unpaid'
      payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)

      case payment_intent.status
      when 'succeeded'
        Rails.logger.info "---Payment Intent #{payment_intent.id} complete!---"
        # TODO - i think i need to re-route this to a payment handler but i'm trying to focus on another problem rn - so this is a backburner thing
      when 'processing'
        Rails.logger.info "---Payment Intent #{payment_intent.id} for Checkout Session #{checkout_session.id} PROCESSING...---"

        order.update(status: 'payment processing')
        checkout.update(status: 'payment_processing')
      when 'requires_payment_method', 'requires_action', 'requires_confirmation'
        Rails.logger.warn "---Payment Issue! #{payment_intent.id}has status of #{payment_intent.status}---"

        order.update(status: payment_intent.status)
        checkout.update(status: payment_intent.status)

        AdminMailer.payment_issue_notification(checkout_session, payment_intent)
      else
        Rails.logger.warn "---Unexpected Payment Intent Status---"
        Rails.logger.warn "---Payment Intent #{payment_intent.id} has a status of #{payment_intent.status}---"
        
        AdminMailer.payment_issue_notification(checkout_session, payment_intent)
      end
    end
  end

  def handle_async_payment_succeeded(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)

    order = Order.find_by(payment_intent_id: payment_intent.id)
    checkout = Checkout.find_by(payment_intent_id: payment_intent.id)

    if payment_intent.status == 'succeeded'
      order.update(status: 'paid')
      checkout.update(status: 'paid')
      OrderMailer.received(order).deliver_later
    else
      Rails.logger.warn "---Unexpected Payment Intent Status for PI# #{payment_intent.id} -- #{payment_intent.status}"
      AdminMailer.payment_issue_notification(checkout_session, payment_intent)
    end
  end

  def handle_async_payment_failed(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)

    order = Order.find_by(payment_intent_id: payment_intent.id)
    checkout = Checkout.find_by(payment_intent_id: payment_intent.id)

    order.update(status: 'payment failed')
    checkout.update(status: 'payment failed')

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
end