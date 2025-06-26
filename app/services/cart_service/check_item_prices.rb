module CartService
  class CheckItemPrices < ApplicationService

    # TODO - manually test out these changes Thursday
    def self.call(cart:)
      cart_items = cart.cart_items.to_a

      cart_items.each do |item|
        product = Stripe::Product.retrieve({
          id: item.stripe_product_id,
          expand: ['default_price'],
        })

        current_default_price_object = product.default_price

        Rails.logger.info "Current item price: #{item.price}"
        Rails.logger.info "Stripe Product default price: #{current_default_price_object.unit_amount}"
        Rails.logger.info "Stripe Product default price ID: #{current_default_price_object.id}"

        if item.price != current_default_price_object.unit_amount
          item.update(price: current_default_price_object.unit_amount)
          Rails.logger.info "new item price: #{item.price}"
        end
      end

      cart.reload
      cart
    end
  end
end