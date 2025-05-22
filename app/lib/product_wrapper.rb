class ProductWrapper < SimpleDelegator
  def price
    product = __getobj__
    price = (Stripe::Price.retrieve(product.default_price)
                          .unit_amount) / 100.00
  end

  # slug? instead of product id

  # DB - denormalize and add relevant fields into cart_items before you drop Products table
end

# ProductWrapper.new(StripeProduct.new)

