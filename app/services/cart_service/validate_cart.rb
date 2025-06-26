module CartService
  class ValidateCart < ApplicationService
    def self.call(cart:)
      cart, unavailable_items = CheckItemInventory.call(cart:)
      cart, items_with_price_changes = CheckItemPrices.call(cart:)
      
      cart.reload
      [cart, unavailable_items, items_with_price_changes]
    end
  end
end