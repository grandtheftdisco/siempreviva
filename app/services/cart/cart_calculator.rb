class Cart
  class CartCalculator

    def self.call(cart:)
      return if !cart.cart_items
      sum_cart_items(cart)
    end

    private

    def self.sum_cart_items(cart)
      items_hash = cart.cart_items.group_by { |item| item.product_id }

      cart.total_amount += items_hash.sum do |item_array|
                              # array[1] is itself an array of the cart items with the same product id
                              quantity = item_array[1].size
                              cart_item_price = item_array.dig(1, 0).price
                              cart_item_name = item_array.dig(1, 0).product.name
                              cart_item_price * quantity
                            end
    end

      ##### GROUP BY PRODUCT ID FIRST, THEN BY PRICE.
# coming back to this in a second



    # consider an AddToCart service object to handle incrementing your cart item quantity cols - outsource that work within CArtCalc to the AddToCart


    # -------------------------------------------------
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