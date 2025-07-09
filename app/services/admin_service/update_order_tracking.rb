module AdminService
  class UpdateOrderTracking < ApplicationService
    def self.call(order:)
      Rails.logger.debug "TRACKING NUMBER FOR ORDER: #{order.tracking_number} <-------"
      begin
        intent = Stripe::PaymentIntent.update(
          order.payment_intent_id,
          metadata: { 
            tracking_number: order.tracking_number
         }
        )
        Rails.logger.info "Successfully added tracking number to PaymentIntent #{intent.id}"
      rescue Stripe::StripeError => e
        Rails.logger.warn "Error: #{e.message}"
      end
    end
  end
end
