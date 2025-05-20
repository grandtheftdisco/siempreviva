# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

Product.delete_all
ProductCategory.delete_all

product_category = ProductCategory.create!(name: "Essential Oils Test Category")

Product.create!(
  name: 'Melissa', 
  price: 1800, 
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RKACrC2evWDh2V2MlDwc5z7',
  stripe_product_id: 'prod_SEdTk1bZbKa6a1'
)
Product.create!(
  name: 'Sage',
  price: 900,
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RKAB0C2evWDh2V2OVPut3p7',
  stripe_product_id: 'prod_SEdRAILBQj1iOb'
)
Product.create!(
  name: 'Immortelle',
  price: 2000,
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RK5efC2evWDh2V2lkvdqQB2',
  stripe_product_id: 'prod_SEYmDAzbEBHtC5'
)
Product.create!(
  name: 'Roman Chamomile',
  price: 1500,
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RK5cIC2evWDh2V2kvNl4dFV',
  stripe_product_id: 'prod_SEYjnKbDeuvVQW'
)
Product.create!(
  name: 'Hyssop',
  price: 1100,
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RK5fSC2evWDh2V21BNqbarM',
  stripe_product_id: 'prod_SEYinuRcBDegmN'
)
Product.create!(
  name: 'Lavender',
  price: 1000,
  product_category_id: product_category.id,
  stripe_price_id: 'price_1RJKDAC2evWDh2V2p8E2Uo8W',
  stripe_product_id: 'prod_SDljakyHifZra3'
)
puts "#{Product.count} products created"

Product.all.each do |product|
  puts product.name
  puts product.price
end

ProductCategory.all.each do |pc|
  puts pc.name
end