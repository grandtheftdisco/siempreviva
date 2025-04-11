class Product < ApplicationRecord
  belongs_to :product_category
  has_many :line_items
end
