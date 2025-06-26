module CartService
  class ValidateCart < ApplicationService
    def self.call(cart:)
      cart, unavailable_items = CheckItemInventory.call(cart:)
      cart = CheckItemPrices.call(cart:)

      cart.reload
      [cart, unavailable_items]
    end
  end
end