class CartCalculator
  def initialize
    # set_cart could go here? (CurrentCart concern)
      # if yes, this eliminates need to include CurrentCart in multiple controllers
  end

  # prepare_product (Cart's add_product method [misnamed]) / set_price (CartItem model)
    # builds a cart_item instance with attrs of a passed-in product instance
      # price
      # name
    # increments cart's total_amount with cart_item's price
    # returns a cart_item to be added to a designated @cart
  
  # add_product
    # save the cart_item that's been associated with a specific cart
    # some overlap w/ previous procedure

  # update_quantity
    # if a specific product is already in the cart as a cart_item and the user
    # adds that product to their cart, the quantity of the cart_item gets incremented

  # save_cart
    # saves current cart with updates to cart_items and or quantity of extant cart_items

end