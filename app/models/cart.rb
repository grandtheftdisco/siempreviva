class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :session_id, presence: true, uniqueness: true

  def add_product(product)
    cart_item = cart_items.build(product: product)
    if cart_item.price.present?
      self.total_amount += cart_item.price
    else
      raise "CartItem price is not set"
    end
    cart_item
  end
end
