class Cart
  class CartCalculator

    def self.call(cart:)
      return if !cart.cart_items
      # check_quantity_of_each_product(cart)
      sum_cart_items(cart)
    end

    private

    # in first iteration whereby we're multiplying cart item price by quantity - NOT incrementing quantity
    def self.sum_cart_items(cart)
      items_hash = cart.cart_items.group_by { |item| item.product_id }
      cart_items_array = items_hash.values.flatten

      cart_total = cart_items_array.sum do |item|
                     item.price
                   end
      return cart_total
    end

              # in v2- check quantity of each cart item - if there are two cart items with the same id, delete the newer one and increment the 'quantity' col of the first 

    def self.check_quantity_of_each_product(cart)
      # if there is more than 1 cart item with the same product_id, sum their quantities.

      # then create a new cart item with that quantity, and all the same fields as the 'extras'.

      # then, delete the extras.

    end

    # consider an AddToCart service object to handle incrementing your cart item quantity cols - outsource that work within CArtCalc to the AddToCart

    # #reduce is an alternative to this "group_by then .sum" strategy you're using - it could do it all in one go. might be too hairy to get into with this method right now - save it for more complex tasks or larger data sets

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