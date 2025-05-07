require "test_helper"

class CartCalculatorTest < ActiveSupport::TestCase
  test "given an empty cart, total should be $0" do
    # make new cart
    cart = Cart.new(total_amount: 0)

    # do the thing you're testing
    total = Cart::CartCalculator.call(cart: cart)
    
    # assertion - expected first, actual second
    assert_equal(0, total)
  end

  test "given a non-empty cart, return total of the cart" do
    cart = Cart.new(total_amount: 13)
    # make a line item for the cart
    # add that item to cart to get your total_amount instead of hardcoding it as 13 above

    total = Cart::CartCalculator.call(cart:)

    assert_equal(13, total)
  end
end