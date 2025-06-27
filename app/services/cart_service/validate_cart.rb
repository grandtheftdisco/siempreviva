module CartService
  class ValidateCart < ApplicationService
    def self.call(cart:)
      cart, unavailable_items = CheckItemInventory.call(cart:)
      cart, price_changes = CheckItemPrices.call(cart:)

      cart.reload
      [cart, unavailable_items, price_changes]
    end
  end
end