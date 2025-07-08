class AddIndexingToCartItemsAgain < ActiveRecord::Migration[8.0]
  def up
    unless index_exists?(:cart_items, [:cart_id, :stripe_product_id], unique: true)
      add_index :cart_items, [:cart_id, :stripe_product_id], unique: true
    end
  end

  def down
    if index_exists?(:cart_items, [:cart_id, :stripe_product_id], unique: true)
      remove_index :cart_items, column: [:cart_id, :stripe_product_id]
    end
  end
end
