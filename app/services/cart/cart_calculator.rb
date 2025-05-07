class Cart #module that CartCalculator needs to inherit from - may need to rename 
  class CartCalculator

    def self.call(cart:)
      # rewrite so that it passes BOTH tests.
      # then once you pass all tests, add another test.
      # never change your tests once they pass. add another one.

      return cart.total_amount



      # you'll also want to read through the articles he sent over. the 3rd one will talk about strategies for structuring a service object.
      # once you decide whether to lean OO or func, you'll jknow how to handle each of the methods you've laid out below. some of these might need to be service objects themselves. others could be private methods that get called within self.call. 
      # this class may take you next week, too. be patient. don't rush just because you think you need to push some code.
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