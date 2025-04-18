class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :session_id, presence: true, uniqueness: true

  def add_product(product)
    cart_item = cart_items.build(product: product)
    cart_item.price = product.price
    cart_item.product_id = product.id
    self.total_amount += cart_item.price
    cart_item
  end
end
