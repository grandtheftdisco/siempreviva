class CheckAsyncPaymentJob < ApplicationJob
  queue_as :default
  retry_on ProcessingPaymentError, wait: 1.hour, attempts: 5
  after_retry_exhausted do |job, exception|
    AdminMailer.retry_limit_notification(job.arguments.first, exception.payment_intent).deliver_now
  end

  def perform(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)

    case payment_intent.status
    when 'succeeded'
      PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session: checkout_session)
    when 'processing'
      raise ProcessingPaymentError.new(checkout_session, payment_intent)
    when 'canceled'
      handle_canceled_payment(checkout_session, payment_intent)
    else
      handle_unexpected_payment_intent_status(checkout_session, payment_intent)
    end
  end

  private

  def handle_canceled_payment(checkout_session, payment_intent)
    Rails.logger.warn "---From AsyncPaymentJob: CANCELED PAYMENT---"

    AdminMailer.payment_issue_notification(checkout_session, payment_intent)

    order = Order.find_by(payment_intent_id: payment_intent)
    checkout = Checkout.find_by(payment_intent_id: payment_intent)

    order.update(status: 'canceled')
    checkout.update(status: 'canceled')
  end

  def handle_unexpected_payment_intent_status(checkout_session, payment_intent)
    Rails.logger.warn "---From AsyncPaymentJob: UNEXPECTED PAYMENT INTENT STATUS: #{payment_intent.status}---"
    Rails.logger.warn "#{payment_intent.inspect}"

    AdminMailer.payment_issue_notification(checkout_session, payment_intent)
  end
end

### custom errors ###
class ProcessingPaymentError < StandardError
  attr_reader :checkout_session, :payment_intent

  def initialize(checkout_session, payment_intent)
    @checkout_session = checkout_session
    @payment_intent = payment_intent
    super("Payment is still processing for Checkout Session #{@checkout_session.id}")
  end
end