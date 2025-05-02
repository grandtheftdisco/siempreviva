class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :session_id, presence: true, uniqueness: true

  def add_product(product)
    cart_item = cart_items.build(product: product)
    cart_item.price = product.price # had to set this explicitly, not sure if cleaner way to write
    if cart_item.price.present?
      self.total_amount += cart_item.price
    end
    cart_item
  end
end
