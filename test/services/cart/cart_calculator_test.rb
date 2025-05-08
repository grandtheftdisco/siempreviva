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
  test "given a non-empty cart, return total of the cart" do
    cart = Cart.create!(session_id: "sdfhsdl")
    cart_item = CartItem.create!(price: products(:two).price, 
                                 cart_id: cart.id, 
                                 product_id: products(:two).id)
    total = Cart::CartCalculator.call(cart:)

    assert_equal(products(:two).price, total)
  end

  ############################################################
  # DO NOT TOUCH THIS TEST
  ############################################################
  test "when an item is added to the cart, the cart's total_amount is updated" do
    cart = Cart.create(session_id: "adjfhsdkf")
    cart_item = CartItem.create!(price: products(:one).price, 
                                 cart_id: cart.id, 
                                 product_id: products(:one).id)
    total = Cart::CartCalculator.call(cart:)

    assert_equal(products(:one).price, total)
  end

  # test "when a 2nd instance of a product is added to a cart, the existing cart item's quantity gets updated" do
  
  # test adding a different product to a cart that already has a cart item
end