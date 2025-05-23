class CartItem < ApplicationRecord
  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  before_validation :set_quantity
  before_validation :set_price

  def price_in_dollars
    self.price / 100.00
  end

  private

  def set_quantity
    if self.quantity == 0 || !self.quantity
      self.quantity = 1
    end
  end

  # REVIEW - is there a way to do this without an API call?
  def set_price
    @products = Stripe::Product.list(active: true, limit: 100).map do |product|
      ProductWrapper.new(product)
    end

    related_product = @products.find { |product| product.id === self.stripe_product_id }

    self.price ||= related_product.price if related_product.present?
  end
end
