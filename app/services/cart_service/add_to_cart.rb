module CartService
  class AddToCart < ApplicationService
    def self.call(product:, cart:, quantity:)
      check_for_duplicate_cart_items(product:, cart:, quantity:)
    end

    private

    def self.check_for_duplicate_cart_items(product:, cart:, quantity:)
      begin
        cart_items = cart.cart_items.to_a
        existing_item = cart_items.find { |i| i.stripe_product_id == product.id }
        
        # checking the price to be 100% sure - trying to avoid this 'nil can't be coerced into integer' error i get when i add an item to an empty cart
        # seeing if this works
        stripe_product = Stripe::Product.retrieve(product.id)
        stripe_price = Stripe::Price.retrieve(stripe_product.default_price)

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
      rescue Stripe::StripeError => edit
        Rails.logger.error("Stripe error: #{e.message}")
        flash[:error] = "Unable to add item to cart. Please try again later."
        redirect_to products_path
      rescue StandardError => e
        Rails.logger.error("Error adding item to cart: #{e.message}")
        flash[:error] = "An error occurred. Please try again later."
        redirect_to products_path
      end
    end
  end
end