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

    handle_stripe_event(event)

    head :ok
  end

  private

  # Stripe event router
  def handle_stripe_event(event)
    case event.type
    # i changed to watching for payment intent success since a completed checkout session could have an unprocessed payment
    when 'payment_intent.succeeded'
      handle_checkout_session_completed(event.data.object)
    when 'payment_intent.payment_failed'
      Rails.logger.info "PAYMENT FAILED PAYMENT FAILED PAYMENT FAILED"
    # for wednesday - refunds
    when 'refund.created'
      Rails.logger.info "---------------------REFUND CREATED"
      # handle refund creation
    else
      puts "Unhandled event type: #{event.type}"
    end
  end

  def handle_checkout_session_completed(payment_intent)
    Rails.logger.info "I'd create an Order if I could!"
    Rails.logger.info "++++ #{payment_intent.inspect}"
    order = Order.create!(
      payment_intent_id: payment_intent.id,
      stripe_customer_id: payment_intent.customer,
      # customer_email_address: ,
      amount: payment_intent.amount,
      status: payment_intent.status
    )
    Rails.logger.info "I'd send mail if I could!"
    OrderMailer.received(order).deliver_later
  end
end