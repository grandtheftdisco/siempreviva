module WebhookSynchronizationService
  class HandlePendingAsyncPayment < ApplicationService
    def self.call(checkout_session:, cart:)
      return false unless async_payment_processing?(checkout_session)

      cart.soft_delete_records
      cart.update(status: "pending")
      true
    end

    private

    def self.async_payment_processing?(checkout_session)
      return false unless checkout_session.payment_status == "unpaid"

      payment_intent = Stripe::PaymentIntent.retrieve(checkout_session.payment_intent)
      payment_intent.status == "processing"
    end
  end
end
