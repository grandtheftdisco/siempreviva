class RemoveProductIdFromCartItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :cart_items, :product_id, null: false
  end
end
