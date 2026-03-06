class CartItem < ApplicationRecord
  include SoftDeletable

  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  before_validation :set_quantity

  private

  def set_quantity
    self.quantity ||= 1
  end
end
