module PaymentHandlingService
  class HandleSuccessfulPayment < ApplicationService
    def self.call(checkout_session:, cart:)
      cart.destroy! if cart.present?
      
      add_order_to_database(checkout_session)
      update_checkout_in_database(checkout_session)
    end

    private

    def self.add_order_to_database(checkout_session)
      @order = Order.create!(
        payment_intent_id: checkout_session.payment_intent,
        stripe_customer_id: checkout_session.customer,
        customer_email_address: checkout_session.customer_email,
        amount: checkout_session.amount_total,
        status: checkout_session.status
      )
      OrderMailer.received(@order).deliver_later
    end

    def self.update_checkout_in_database(checkout_session)
      checkout = Checkout.find_by(stripe_checkout_session_id: checkout_session.id)
      checkout.update(status: "awaiting shipment")
    end
  end
end