class CartItem < ApplicationRecord
  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  before_validation :set_quantity
  before_validation :set_price

  private

  def set_quantity
    if self.quantity == 0 || !self.quantity
      self.quantity = 1
    end
  end
  def set_price
    # FIXME - this method needs to be updated for Stripe paradigm
    self.price ||= product.price if product.present?
  end
end
