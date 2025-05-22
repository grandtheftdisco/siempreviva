class AddNewIndexToCartItems < ActiveRecord::Migration[8.0]
  def change
    add_index :cart_items, [:cart_id, :stripe_product_id], unique: true
  end
end
