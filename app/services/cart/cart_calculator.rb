class Cart
  class CartCalculator

    def self.call(cart:)
      return if !cart.cart_items
      check_for_duplicate_cart_items(cart)
      calculate_cart_total(cart)
    end

    # private

    def self.check_for_duplicate_cart_items(cart)
      items = cart.cart_items.to_a
      if items.size > 1
        new_cart_item = CartItem.create!(price: items[0].price,
                                         cart_id: cart.id,
                                         product_id: items[0].product_id,
                                         quantity: items.size)
        # TODO - refactor this to be iterative
        items[0].destroy!
        items[1].destroy!
      end
    new_cart_item
    end

    def self.calculate_cart_total(cart)
      total = cart.cart_items.inject(0){ |res, item| item.price + res }
    end
    #-------------------------------------------------
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