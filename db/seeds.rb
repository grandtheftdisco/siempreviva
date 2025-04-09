# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.delete_all
ProductCategory.delete_all
puts "products deleted"
puts "product categories deleted"

product_category = ProductCategory.create!(name: "Essential Oils Test Category")

product = Product.create(name: 'lavender', price: 15, product_category_id: product_category.id)
product.save!

puts "#{Product.count} products created"
puts product.name
puts product_category.name