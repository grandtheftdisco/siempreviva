module AdminService
  class UpdateOrderTracking < ApplicationService
    def self.call(order:)
      begin
        intent = Stripe::PaymentIntent.update(
          order.payment_intent_id,
          metadata: { 
            tracking_number: order.tracking_number,
            test_field: "123testfield"
         }
        )
        Rails.logger.info "Successfully added tracking number to PaymentIntent #{intent.id}"
      rescue Stripe::StripeError => e
        Rails.logger.warn "Error: #{e.message}"
      end
    end
  end
end

TODO
1. tracking number not getting sent via metadata unless i'ts a hardcoded string - but the test_field kv pair get ssent.
2. stripe sig verification issue in server logs ...?