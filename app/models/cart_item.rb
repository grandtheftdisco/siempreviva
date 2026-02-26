class CartItem < ApplicationRecord
  include SoftDeletable

  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  before_validation :set_quantity

  private

  def set_quantity
    self.quantity ||= 1
  end
end
