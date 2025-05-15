class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :product_id, uniqueness: { scope: :cart_id }
  before_validation :set_price

  private

  def set_price
    self.price ||= product.price if product.present?
  end
end
