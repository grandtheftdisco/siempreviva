module WebhookSynchronizationService
  class EnsurePaymentProcessed < ApplicationService
    def self.call(stripe_checkout_session_id:)
      checkout_session = Stripe::Checkout::Session.retrieve(stripe_checkout_session_id)
      local_checkout_record = Checkout.find_by(stripe_checkout_session_id: stripe_checkout_session_id)
      
      return false unless local_checkout_record
      return false if already_processed?(local_checkout_record)
      return false unless payment_complete?(checkout_session)
      
      Rails.logger.info "🚀 Processing payment synchronously for checkout session #{stripe_checkout_session_id}"
      
      cart = Cart.find(local_checkout_record.cart_id)
      PaymentHandlingService::HandleSuccessfulPayment.call(
        checkout_session: checkout_session,
        cart: cart
      )
      
      true
    rescue => e
      Rails.logger.error "🚀 Error in synchronous payment processing: #{e.message}"
      false
    end

    private

    def self.already_processed?(local_checkout_record)
      local_checkout_record.status == 'awaiting shipment'
    end

    def self.payment_complete?(checkout_session)
      checkout_session.payment_status == 'paid' || 
      checkout_session.payment_status == 'no_payment_required'
    end
  end
end