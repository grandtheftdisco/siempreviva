require "test_helper"

class CartCalculatorTest < ActiveSupport::TestCase
  test "given an empty cart, total should be $0" do
    #  step 1: make new cart
    cart = Cart.new(total_amount: 0)
    cart_item = CartItem.new
    # step 2: do the thing you're testing
    total = Cart::CartCalculator.call(cart: cart, cart_item: cart_item)
    
    # step 3: assertion - expected first, actual second
    assert_equal(0, total)
  end

  test "given a non-empty cart, return total of the cart" do
    cart = Cart.new
    cart_item = CartItem.new(price: 13)
    total = Cart::CartCalculator.call(cart:, cart_item:)

    assert_equal(13, total)
  end

  test "when an item is added to the cart, the cart's total_amount is updated" do
    cart = Cart.new
    cart_item = CartItem.new(price: 6)
    total = Cart::CartCalculator.call(cart:, cart_item:)

    assert_equal(6, total)
  end

  # test "when a 2nd instance of a product is added to a cart, the existing cart item's quantity gets updated" do
  
  # test adding a different product to a cart that already has a cart item
end