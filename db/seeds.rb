# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

Product.delete_all
ProductCategory.delete_all

product_category = ProductCategory.create!(name: "Essential Oils Test Category")

Product.create!(
  name: 'Melissa', 
  price: 1800, 
  product_category_id: product_category.id
)
Product.create!(
  name: 'Sage',
  price: 900,
  product_category_id: product_category.id
)
Product.create!(
  name: 'Immortelle',
  price: 2000,
  product_category_id: product_category.id
)
Product.create!(
  name: 'Roman Chamomile',
  price: 1500,
  product_category_id: product_category.id
)
Product.create!(
  name: 'Hyssop',
  price: 1100,
  product_category_id: product_category.id
)
Product.create!(
  name: 'Lavender',
  price: 1000,
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