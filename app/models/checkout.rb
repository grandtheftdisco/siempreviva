class Checkout < ApplicationRecord
  belongs_to :cart
  validates :cart_id, presence: true
end