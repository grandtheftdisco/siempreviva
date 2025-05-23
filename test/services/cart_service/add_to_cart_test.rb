require "test_helper"

class AddToCartTest < ActiveSupport::TestCase
  test "when a product is added to the cart for the first time, a new cart item is created with that product's attributes" do
    cart = carts(:empty) 
    product = products(:rose)
    quantity = 1
    CartService::AddToCart.call(product:, cart:, quantity:) 

    new_cart_item = cart.cart_items.find_by(product_id: product.id)
    assert_includes(cart.cart_items.reload, new_cart_item)
  end

  test "when a product has already been added to a cart, adding it again increments the quantity of the existing cart item" do
   cart = carts(:mary)
   product = products(:lavender)
   quantity = 1
   CartService::AddToCart.call(product:, cart:, quantity:)
   
   new_cart_item = cart.cart_items.reload.find_by(product_id: product.id)
   assert_equal(2, new_cart_item.quantity)
  end
end