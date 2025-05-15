module CartService
  class AddToCart < ApplicationService
    def self.call(product:, cart:)
      check_for_duplicate_cart_items(product:, cart:)
      
    end

    private

    def self.check_for_duplicate_cart_items(product:, cart:)
      cart_items = cart.cart_items.to_a
      if cart_items.any? { |item| item.id == product.id }
        item.quantity += product.quantity # how to pass this; as a param?
      else
        new_cart_item = CartItem.create!(price: product.price,
                                         cart_id: cart.id,
                                         product_id: product.id,
                                         quantity: 1) # need to handle other quantities 
        cart.cart_items.reload
        new_cart_item
      end 
    end
  end
end