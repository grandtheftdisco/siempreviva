require "test_helper"

class CalculatorTest < ActiveSupport::TestCase
  test "given an empty cart, total should be $0" do
    #  step 1: make new cart
    cart = carts(:empty)

    # step 2: do the thing you're testing
    total = CartService::Calculator.call(cart: cart)
    
    # step 3: assertion - expected first, actual second
    assert_equal(0, total)
  end

  test "when an item is added to the cart, the cart's total_amount is updated" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    total = CartService::Calculator.call(cart:)

    assert_equal(products(:lavender).price, total)
  end

  test "when a 2nd item is added to a cart, the cart total should match the sum of the 2 cart items" do
    cart = carts(:mary)
    cart_items(:lavender)
    cart.cart_items << cart_items(:rose)
    total = CartService::Calculator.call(cart:)

    assert_equal(30, total)
  end

  test "when a 2nd instance of a product is added, the cart total is double the price of the product" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    cart_item_second = cart_item_first.dup
    cart_item_second.save!

    total = CartService::Calculator.call(cart:)

    assert_equal(products(:lavender).price * 2, total)
  end

  test "if two CartItems have the same product_id, a new CartItem is created with a quantity of 2" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    cart_item_second = cart_item_first.dup.tap(&:save!)
  
    CartService::Calculator.call(cart: cart)
  
    new_cart_item = cart.cart_items.find_by(product_id: cart_item_first.product_id)
  
    assert(new_cart_item.present?)
    assert_equal(2, new_cart_item.quantity)
  end

  test "if three CartItems have the same product_id, a new CartItem is created with a quantity of 3" do
    cart = carts(:mary)
    cart_item_first = cart_items(:lavender)
    cart_item_second = cart_item_first.dup.tap(&:save!)
    cart_item_third = cart_item_second.dup.tap(&:save!)

    CartService::Calculator.call(cart: cart)

    new_cart_item = cart.cart_items.find_by(product_id: cart_item_first.product_id)

    assert(new_cart_item.present?)
    assert_includes(cart.cart_items.reload, new_cart_item)
    assert_equal(3, new_cart_item.quantity)
  end

  # test - 1 of ProductOne, 2 of ProductTwo - assert cart's total adds up to the total of these prices

  # test - 3 of ProductOne, 2 of ProductTwo - assert cart total adds up to total of these prices

  # other test cases?

  # LATER - read discount docs and write discount tests
end