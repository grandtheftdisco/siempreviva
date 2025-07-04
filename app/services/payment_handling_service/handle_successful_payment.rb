module PaymentHandlingService
  class HandleSuccessfulPayment < ApplicationService
    def self.call(checkout_session:)
      # cart.destroy!
      # Rails.logger.debug "the cart actually got destroyed, right?"
      # Rails.logger.debug "to be sure, here is cart: #{cart.inspect}"
      Rails.logger.debug "WE GOT AN ORDER BEING CREATED........"
      # add Order record to pg db
      @order = Order.create!(
        payment_intent_id: checkout_session.payment_intent,
        stripe_customer_id: checkout_session.customer,
        customer_email_address: checkout_session.customer_email,
        amount: checkout_session.amount_total,
        status: checkout_session.status
      )
      # OrderMailer.received(@order).deliver_later

      # update Checkout record in pg db
      checkout = Checkout.find_by(stripe_checkout_session_id: checkout_session.id)
      checkout.update(status: checkout_session.status)
    end
  end
end