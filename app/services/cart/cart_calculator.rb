class Cart
  class CartCalculator

    def self.call(cart:)
      return if !cart.cart_items
      combine_duplicate_cart_items(cart)
      sum_cart_items(cart)
    end

    private

    def self.sum_cart_items(cart)
      cart.cart_items.each do |item|
        cart.total_amount += item.price
      end
      return cart.total_amount
    end

    def self.combine_duplicate_cart_items(cart)
      # check quantity of each cart item - if there are two cart items with the same id, delete the newer one and increment the 'quantity' col of the first 

      ##### GROUP BY PRODUCT ID FIRST, THEN BY PRICE.
# coming back to this in a second

      items_hash = cart.cart_items.group_by { |item| item.product_id }

      puts "----------begin----------------"
      puts "here's the items hash:"
      puts items_hash
      puts "here's the item hash length:"
      puts items_hash.length
      puts items_hash

      # if items_hash.length == 1
      #   # one product in cart, quantity unknown
      #   # the key is the product id, the value is the cart item object
        
      # elsif items_hash.length > 1
      #   # more than 1 product in cart, quantity of each line item unknown
      #   items_hash.each do |item|
          
      #   end
      # end

      ### OR 

      # if the item hash length is greater than 1, this ostensibly means we've got more than one product, which means we can just add the prices of these items into the cart total

      # if the item hash length == one,
        # figure out how to access the value of this hash - is it an array of items with the relevant product id? if so, just grab the length of that array and multiply it by the price.
      
      # elsif items hash length == 0 
        # return/skip to next item in collection

      items_hash.each do |array|
        puts "here's the nested array length (ie # of cart items with same product id):"
        puts array.length
        puts "here's array at index 1"
        puts array[1].inspect
        # puts "what type is it?"
        # puts array[1].class
        l = array[1].length
        puts "here's the cart item price"
        puts array.dig(1, 0).price
        puts "here is the item total with quantity in mind"
        puts array.dig(1, 0).price * l # doesnt work but hold on
        puts "here is the length of the same-product-id items array"
        puts array[1].length

        # so if we dig into the array, 1 is always our first level, since array[0] is just a product id. array[1] gives us a one-item array. then when dig further ie 1 then 0 (1,0), that means we're digging into the actual cart item object, and THAT is when we can call price
        puts "------------end---------------"
      end


      # is there a way to sort a collection by a particular attribute/kv pair? like create a series of smaller arrays that are grouped by product_id
    end

    # sort array of cart items into sub_arrays, by price
      # for each sub_array
        # if sub_array.count == 1
          # return sub_array[0].price // cart.total += sub_array[0].price
        # elsif sub_array.count > 1
          # item_total = multiply item's price by sub_array.count
          # cart.total += item_total
        # end
      # end


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