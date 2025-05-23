class ProductWrapper < SimpleDelegator
  # in cents; for calculations & Stripe transaction logic
  def price
    Stripe::Price.retrieve(self.default_price)
                 .unit_amount
  end

  # for view display of pricing only
  def price_in_dollars
    price / 100
  end
end