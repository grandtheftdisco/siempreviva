module CartService
  class CheckItemPrices < ApplicationService
    def self.call(cart:)
      cart_items = cart.cart_items.to_a

      items_with_price_changes = []

      cart_items.each do |item|
        product = Stripe::Product.retrieve({
          id: item.stripe_product_id,
          expand: ['default_price'],
        })

        current_price = product.default_price.unit_amount
        old_price = item.price

        if item.price != current_price
          item.update(price: current_price)
          items_with_price_changes << { item: item,
                                        old_price: old_price,
                                        new_price: current_price
                                      }
        end
      end

      cart.reload
      [cart, items_with_price_changes]
    end
  end
end