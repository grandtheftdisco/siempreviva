module CartService
  class CheckItemInventory < ApplicationService
    def self.call(cart:)
      unavailable_items = confirm_all_products_in_cart_are_active(cart)

      # returning unavailable items array to customize the alert to customer
      [cart, unavailable_items]
    end

    private

    def self.confirm_all_products_in_cart_are_active(cart)
      cart_items = cart.cart_items.to_a
      
      active_cart_items = cart_items.reject do |item|
        product = Stripe::Product.retrieve(item.stripe_product_id)
        product.active == false
      end

      unavailable_items = cart_items - active_cart_items

      if unavailable_items.any?
        # log the array for debugging/customer service
        Rails.logger.warn "these items aren't available anymore: #{unavailable_items.inspect}"
        unavailable_items.each(&:destroy)
      end

      cart.reload
      unavailable_items
    end
  end
end