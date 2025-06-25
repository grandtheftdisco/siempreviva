module CartService
  # top-level validator - calls 2 separate services and returns updated/reloaded cart
  class ValidateCart < ApplicationService
    def self.call(cart:)
      CheckItemInventory.call(cart)
      CheckItemPrices.call(cart)

      cart.reload
    end
  end
end