class ProductWrapper < SimpleDelegator
  # in cents; for calculations & Stripe transaction logic
  def price
    product = __getobj__
    price = (Stripe::Price.retrieve(product.default_price)
                          .unit_amount)
  end

  # for view display of pricing only
  def price_in_dollars
    price = self.price / 100
  end
end