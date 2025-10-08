module PaymentHandlingService
  class HandleSuccessfulPayment < ApplicationService
    def self.call(checkout_session:, cart:)
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
      local_checkout_record = Checkout.find_by(stripe_checkout_session_id: checkout_session.id)
      local_checkout_record.update(status: "awaiting shipment",
                                   payment_intent_id: checkout_session.payment_intent)
    end

    def self.clear_cart_items(cart)
      cart.soft_delete_records
    end
  end
end