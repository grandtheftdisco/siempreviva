require "test_helper"

class CartCalculatorTest < ActiveSupport::TestCase
  ############################################################
  # DO NOT TOUCH THIS TEST
  ############################################################
  test "given an empty cart, total should be $0" do
    #  step 1: make new cart
    cart = Cart.create!(session_id: "123fdsdsfd")

    # step 2: do the thing you're testing
    total = Cart::CartCalculator.call(cart: cart)
    
    # step 3: assertion - expected first, actual second
    assert_equal(0, total)
  end
  ############################################################
  # DO NOT TOUCH THIS TEST ^^^^^^^^^^^^^^^^^^
  ############################################################

  ############################################################
  # DO NOT TOUCH THIS TEST
  ############################################################
  test "when an item is added to the cart, the cart's total_amount is updated" do
    cart = Cart.create!(session_id: "adjfhsdkf")
    cart_item = CartItem.create!(price: products(:one).price, 
                                 cart_id: cart.id, 
                                 product_id: products(:one).id)
    total = Cart::CartCalculator.call(cart:)

    assert_equal(products(:one).price, total)
  end

  ############################################################
  # DO NOT TOUCH THIS TEST
  ############################################################
  test "when a 2nd item is added to a cart, the cart total should match the sum of the 2 cart items'" do
    cart = Cart.create!(session_id: "adjfhsdkf")
    cart_item_one = CartItem.create!(price: products(:one).price,
                                     cart_id: cart.id,
                                     product_id: products(:one).id)
    cart_item_two = CartItem.create!(price: products(:two).price,
                                     cart_id: cart.id,
                                     product_id: products(:two).id)

    total = Cart::CartCalculator.call(cart:)

    assert_equal(products(:one).price + products(:two).price, total)
  end

  ############################################################
  # DO NOT TOUCH THIS TEST
  ############################################################
  test "when a 2nd instance of a product is added, the cart total is double the price of the product" do
    cart = Cart.create!(session_id: "adjfhsdkf")
    cart_item_first = CartItem.create!(price: products(:one).price,
                                       cart_id: cart.id,
                                       product_id: products(:one).id)
    cart_item_second = CartItem.create!(price: products(:one).price,
                                        cart_id: cart.id,
                                        product_id: products(:one).id)

    total = Cart::CartCalculator.call(cart:)

    assert_equal(products(:one).price * 2, total)
  end


  # test "when a 2nd instance of a product is added to a cart, the cart item's quantity should increment by one" do
    
  # end
  # use quantity col as a multiplier for the price when calculating
end