module CartService
  class CheckItemPrices < ApplicationService
    def self.call(cart:)

      # [?] add the price id to the product wrapper to avoid having to store stripe_price_id in cart_items table?

      # [?] update the cart item by updating the product wrapper?

      ######

      # ...what about setting up a webhook for changes to product status, ie product.updated events where the active attribute of the product object has changed?


      # for all cart items - fetch stripe product - use expandable attributes feature of product object


    # def self.confirm_all_prices_are_current(cart)
    #   Rails.logger.info "cart at beginning of confirm_all_prices_are_current: #{cart.inspect}"
    #   cart_items = cart.cart_items.to_a
    #   Rails.logger.info "cart items after conversion to a: #{cart_items.inspect}"
#############################################
# from original SO

    #   price_changes = cart_items.select do |item|
    #     stripe_price = Stripe::Price.retrieve(item.stripe_price)
    #   # check to make sure all prices are correct
    #     # if any prices have changed
    #       # alert customer ??
    #       # OR
    #       # honor price that they added to their cart
    # end
    end
  end
end