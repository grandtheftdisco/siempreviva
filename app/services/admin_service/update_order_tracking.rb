module AdminService
  class UpdateOrderTracking < ApplicationService
    def self.call(order:)
      send_tracking_number_to_stripe(order)
      update_order_in_database(order)
    end

    private

    def self.send_tracking_number_to_stripe(order)
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

    def self.update_order_in_database(order)
      order.update(status: 'shipped')
      Rails.logger.debug "\e[3;45mORDER UPDATE: order #{order.id} has a status of '#{order.status}'"
    end
  end
end
