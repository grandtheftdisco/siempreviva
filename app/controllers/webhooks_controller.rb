class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook_secret)
      )
    rescue JSON::ParserError => editing
      # invalid payload
      Rails.logger.debug "JSON Parser Error -- invalid payload"
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      # invalid signature
      Rails.logger.debug "Stripe Sig Verification Error - invalid signature"
      return head :bad_request
    end

    head :ok

    handle_stripe_event(event)
  end

  private

  ### Stripe Event Router ###
  def handle_stripe_event(event)

    check_for_duplicate_events(event)

    case event.type
    when 'checkout.session.completed'
      checkout_session = event.data.object
      Rails.logger.debug "Checkout Session Completed: #{checkout_session.inspect}"

      determine_and_handle_payment_status(checkout_session, event)
    when 'refund.created', 'refund.updated'
      Rails.logger.info "---Refund Created and/or Updated---"
      refund = event.data.object
      Rails.logger.info "-0-0-0- Refund: #{refund.inspect} -0-0-0-"
      
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

  def determine_and_handle_payment_status(checkout_session, event)
    case checkout_session.payment_status
    when 'paid'
      PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session:)
    when 'unpaid'
      handle_async_payment(checkout_session)
    when 'no_payment_required'
      handle_no_payment_required(checkout_session)
    else
      Rails.logger.warn "Unknown payment status: #{checkout_session.payment_status}"
      AdminMailer.event_notification(event)
    end
  end

  def handle_async_payment(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)
    Rails.logger.info "---Handling Async Payment... Payment Intent #{payment_intent.id}---"

    checkout = Checkout.find_by(payment_intent_id: payment_intent.id)
    checkout.update(status: payment_intent.status,
                    payment_intent_id: payment_intent.id) 

    CheckAsyncPaymentJob.set(wait: 1.hour).perform_later(checkout_session)
  end

  def handle_no_payment_required(checkout_session)
    Rails.logger.info ":-:-: TEST - handle_no_payment_required :-:-:"
    Rails.logger.info ":-) feature-flagged (-:"
  end

  def handle_refunded_order(refund)
    Rails.logger.info "---Refund Succeeded: #{refund.id}---"
        
    order = Order.find_by(payment_intent_id: refund.payment_intent)
    order.update(status: "refunded on #{DateTime.now}")
    
    checkout = Checkout.find_by(payment_intent_id: refund.payment_intent)
    checkout.update(status: "refunded on #{DateTime.now}")

    OrderMailer.refunded(order).deliver_later
  end

  def handle_unexpected_event(event)
    Rails.logger.warn "[!] ->->-> Unexpected Event:"
    Rails.logger.warn "#{event.inspect}"
    AdminMailer.event_notification(event)
  end
end