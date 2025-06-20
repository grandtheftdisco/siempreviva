class CheckAsyncPaymentJob < ApplicationJob
  queue_as :default

  def perform(checkout_session)
    payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)

    case payment_intent.status
    when 'succeeded'
      PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session: checkout_session)
    when 'processing'
      self.class.set(wait: 1.hour).perform_later(checkout_session)

      # if i've checked a certain number of times, or a certain amount of time has passed, AdminMailer
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
