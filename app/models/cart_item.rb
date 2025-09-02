class CartItem < ApplicationRecord
  include SoftDeletable

  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  before_validation :set_quantity

  private

  def set_quantity
    if self.quantity == 0 || !self.quantity
      self.quantity = 1
    end
  end
end
