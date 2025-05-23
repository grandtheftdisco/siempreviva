require "test_helper"

class CalculateCartTest < ActiveSupport::TestCase
  test "given an empty cart, total should be $0" do
    #  step 1: make new cart
    cart = carts(:empty)

    # step 2: do the thing you're testing
    total = CartService::CalculateCart.call(cart: cart)
    
    # step 3: assertion - expected first, actual second
    assert_equal(0, total)
  end

  test "when an item is added to the cart, the cart's total_amount is updated" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    total = CartService::CalculateCart.call(cart:)

    assert_equal(products(:lavender).price, total)
  end

  test "when a 2nd item is added to a cart, the cart total should match the sum of the 2 cart items" do
    cart = carts(:mary)
    cart_items(:lavender)
    cart.cart_items << cart_items(:rose)
    total = CartService::CalculateCart.call(cart:)

    assert_equal(30, total)
  end

  test "when a 2nd instance of a product is added, the cart total is double the price of the product" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    cart_item_second = cart_item_first.dup
    cart_item_second.save!

    total = CartService::CalculateCart.call(cart:)

    assert_equal(products(:lavender).price * 2, total)
  end
end