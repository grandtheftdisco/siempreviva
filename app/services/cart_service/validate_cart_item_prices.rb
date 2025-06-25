module CartService
  class ValidateCartItemPrices < ApplicationService
    def self.call(cart:)
      # this method should be called 'one last time' before checkout view is rendered

      # [?] add the price id to the product wrapper to avoid having to store stripe_price_id in cart_items table?

      # [?] update the cart item by updating the product wrapper?

      ######

      # ...what about setting up a webhook for changes to product status, ie product.updated events where the active attribute of the product object has changed?


      # for all cart items - fetch stripe product - use expandable attributes feature of product object
    end
  end
end