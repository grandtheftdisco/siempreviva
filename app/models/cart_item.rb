class CartItem < ApplicationRecord
  include SoftDeletable
  # Signals that a quantity-zero update should be treated as a removal.
  # Raised in before_validation; the controller rescues this and handles
  # the actual destruction. We don't destroy in the callback itself because
  # update/update! wraps callbacks in a transaction — a raise here rolls
  # back any destroy that happened within the same callback.
  class CartItemRemoved < StandardError; end

  belongs_to :cart
  validates :stripe_product_id, uniqueness: { scope: :cart_id }
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  before_validation :check_for_zero_quantity
  before_validation :set_quantity

  private

  def check_for_zero_quantity
    return unless quantity.zero?
    raise CartItemRemoved
  end

  def set_quantity
    self.quantity ||= 1
  end
end
