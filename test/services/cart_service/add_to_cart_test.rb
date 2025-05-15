require "test_helper"

class AddToCartTest < ActiveSupport::TestCase
  test "when a product is added to the cart for the first time, a new cart item is created with that product's attributes" do
    cart = carts(:mary) 
    product = products(:rose)
    # add rose to the cart since only lavender exists in mary's cart
    CartService::AddToCart.call(product:, cart:) 

    new_cart_item = cart.cart_items.find_by(product_id: product.id)
    assert_includes(cart.cart_items, new_cart_item)
  end

  # test "when a product has already been added to a cart, adding it again increments the quantity of the existing cart item" do
    
  # end
end