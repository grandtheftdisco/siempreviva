module CartService
  class ValidateCart < ApplicationService
    def self.call(cart:)
      unavailable_items = confirm_all_products_in_cart_are_active(cart)

      confirm_all_prices_are_current(cart)        
      # check to make sure all prices are correct
        # if any prices have changed
          # alert customer ??
          # OR
          # honor price that they added to their cart
      [cart, unavailable_items]
    end

    private

    def self.confirm_all_products_in_cart_are_active(cart)
      Rails.logger.debug "service cart class: #{cart.class}"
      cart_items = cart.cart_items.to_a
      Rails.logger.debug "cart items: #{cart_items.inspect}"
      
      active_cart_items = cart_items.reject do |item|
        product = Stripe::Product.retrieve(item.stripe_product_id)
        product.active == false
      end

      unavailable_items = cart_items - active_cart_items

      if unavailable_items.any?
        # log the array for debugging/cs
        # notify customer using this array 
        # destroy the cart items in question
        Rails.logger.warn "these items aren't available anymore: #{unavailable_items.inspect}"
        unavailable_items.each(&:destroy)
      end

      cart.reload
      unavailable_items
    end

    def self.confirm_all_prices_are_current(cart)

    end
  end
end