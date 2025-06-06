module CartService
  class AddToCart < ApplicationService
    def self.call(product:, cart:, quantity:)
      check_for_duplicate_cart_items(product:, cart:, quantity:)
    end

    private

    def self.check_for_duplicate_cart_items(product:, cart:, quantity:)
      cart_items = cart.cart_items.to_a
      existing_item = cart_items.find { |i| i.stripe_product_id == product.id }
      if existing_item
        existing_item.quantity += quantity
        existing_item.tap(&:save!)
      else
        new_cart_item = CartItem.create!(price: product.price,
                                         cart_id: cart.id,
                                         stripe_product_id: product.id,
                                         image: product.images[0],
                                         name: product.name,
                                         quantity: quantity)
        cart.cart_items.reload
        new_cart_item
      end 
    end
  end
end