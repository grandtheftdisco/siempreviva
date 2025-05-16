module CartService
  class CalculateCart < ApplicationService

    def self.call(cart:)
      return if !cart.cart_items
      calculate_cart_total(cart)
    end

    private

    def self.calculate_cart_total(cart)
      total = cart.cart_items
                  .inject(0){ |res, item| (item.price * item.quantity) + res }
    end
  end
end