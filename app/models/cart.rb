class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :session_id, presence: true, uniqueness: true

  def total_in_dollars
    @total = CartService::CalculateCart.call(cart: self)
    @total / 100
  end
end