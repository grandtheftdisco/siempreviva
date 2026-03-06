require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  test "updating quantity to zero raises CartItemRemoved" do
    cart_item = cart_items(:lavender)
    assert_raises CartItem::CartItemRemoved do
      cart_item.update!(quantity: 0)
    end
    assert_not cart_item.destroyed?, "model signals removal but does not destroy itself"
  end

  test "updating quantity to a valid value does not destroy the cart item" do
    cart_item = cart_items(:lavender)
    cart_item.update!(quantity: 5)
    assert_not cart_item.destroyed?
    assert_equal 5, cart_item.reload.quantity
  end

  test "quantity must be between 1 and 10" do
    cart_item = cart_items(:lavender)
    assert_not cart_item.update(quantity: 11)
    assert_not cart_item.update(quantity: -1)
  end
end
