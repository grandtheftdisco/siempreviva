class CartItem < ApplicationRecord
  include SoftDeletable

  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  before_validation :set_quantity

  private

  def set_quantity
    # FIXME - refine this logic to handle 0-val quantities differently than when self.quanity has changed to a value other than 0
    if self.quantity == 0 || !self.quantity
      self.quantity = 1
    end
  end
end
