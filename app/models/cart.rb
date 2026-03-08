class Cart < ApplicationRecord
  include SoftDeletable

  has_many :cart_items, -> { order(:created_at) }, dependent: :destroy
  validates :session_id, presence: true, uniqueness: { scope: :deleted_at }

  def total
    CartService::CalculateCart.call(cart: self)
  end

  def soft_delete
    super
    soft_delete_records
  end

  def total_quantity_of_line_items
    self.cart_items.sum(&:quantity)
  end
end