class Cart #module that CartCalculator needs to inherit from - may need to rename 
  class CartCalculator

    def self.call(cart:, cart_item:)
      # check to see what cart items you have.
      # for each cart item in this group, sum the totals of their prices
      # FUTURE - use the quantity as a multiplier
      cart.total_amount += cart_item.price.to_i
      return cart.total_amount

      # PROBLEM - I can't pass in an infinite number of cart items.
      # There has to be a better way to grab all of these.
      # apparently trying to use the * operator to sponge up multiple arguments into an array isn't behaving the way I expect it to. A hash of all the arguments gets created.
      # Is there a way to use a private method to identify all the cart items?

    end

    #----------------------------------------------------------
    # add_product (Cart) / set_price (CartItem model)
      # builds a cart_item instance with attrs of a passed-in product instance
        # price
        # name
      # increments cart's total_amount with cart_item's price
      # save cart item 
      # save cart

        # *** could use role_changed? to determine whether cart_items' prices
        # are reflective of the product they're referencing
    

    #----------------------------------------------------------
    # update_quantity
      # if a specific product is already in the cart as a cart_item and the user
      # adds that product to their cart, the quantity of the cart_item gets incremented

        # *** added quantity col to cart_item table to prep for today


    #----------------------------------------------------------
    # apply_discount
      # TBD
      # "a Discount represents the actual application of a Coupon or PromotionCode"

      # must go before calculating tax/shipping, right?
        # "Stripe Tax automatically determines whether shipping is taxable (as taxability varies by state and country) and applies the correct tax rate if so."


    #----------------------------------------------------------
    # handle_subscription
      # not sure if this is the place for this method, but this is something
      # the product owners want to be able to offer


    #----------------------------------------------------------
    # calculate_shipping/add_shipping

      # ask PO - flat rate or calculated another way?


    #----------------------------------------------------------
    # calculate_tax/add_tax

      # start with US-only


    #----------------------------------------------------------
    # save_cart
      # saves current cart with updates to cart_items and or quantity of extant cart_items

      # do i need to define a separate method to ask the cart calculator for the
      # cart's total? ie CartCalculator.total_amount

  end
end