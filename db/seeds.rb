# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

Product.delete_all
ProductCategory.delete_all

product_category = ProductCategory.create!(name: "Essential Oils Test Category")

Product.create!(
  name: 'Blue Tansy', 
  price: 30, 
  product_category_id: product_category.id
)
Product.create!(
  name: 'Rose',
  price: 95,
  product_category_id: product_category.id
)
puts "#{Product.count} products created"

Product.all.each do |product|
  puts product.name
  puts product.price
end

ProductCategory.all.each do |pc|
  puts pc.name
end