class ProductWrapper < SimpleDelegator
  # in cents; for calculations & Stripe transaction logic
  def price
    Rails.cache.fetch("price_info:#{self.default_price}", expires_in: 30.days) do
      Stripe::Price.retrieve(self.default_price)
                  .unit_amount
    end
  end

  # for view display of pricing only
  def price_in_dollars
    price / 100
  end
end