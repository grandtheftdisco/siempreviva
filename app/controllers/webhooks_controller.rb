class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Rails.logger.info "~+~+~+~+~+~ Webhook received ~+~+~+~+~+~+~"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook_secret)
      )
      Rails.logger.info "====EVENT===== #{event.inspect}"
    rescue JSON::ParserError => editing
      # invalid payload
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      # invalid signature
      return head :bad_request
    end

    handle_stripe_event(event)

    head :ok
  end

  private

  # Stripe event router
  def handle_stripe_event(event)
    case event.type
    when 'checkout.session.completed'
      handle_checkout_session_completed(event.data.object)
    when 'payment_intent.created'
      Rails.logger.info "~+~+~+~+~+~ Payment Intent created ~+~+~+~+~+~+~"
    when 'payment_intent.succeeded'
      Rails.logger.info "~+~+~+~+~+~ Payment Intent succeeded ~+~+~+~+~+~+~"
    when 'mandate.updated'
      Rails.logger.info "~+~+~+~+~+~ Mandate updated ~+~+~+~+~+~+~"
    when 'charge.updated'
      Rails.logger.info "~+~+~+~+~+~ Charge updated ~+~+~+~+~+~+~"
    when 'charge.succeeded'
      Rails.logger.info "~+~+~+~+~+~ Charge suceeded ~+~+~+~+~+~+~"
    # add more event types in future: refunds, order shipped, etc
    else 
      puts "Unhandled event type: #{event.type}"
    end
  end

  def handle_checkout_session_completed(checkout_session)
    order = Order.create!(
      payment_intent_id: checkout_session.payment_intent,
      stripe_customer_id: checkout_session.customer,
      customer_email_address: checkout_session.customer_email,
      amount: checkout_session.amount_total,
      status: checkout_session.status
    )
    OrderMailer.received(order).deliver_later
  end
end