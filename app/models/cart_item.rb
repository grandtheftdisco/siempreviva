class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_validation :set_price

  private

  def set_price
    self.price ||= product.price if product.present?
  end
end
