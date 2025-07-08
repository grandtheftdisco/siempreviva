class RemoveProductIdFromCartItemsAgain < ActiveRecord::Migration[8.0]
  def change
    remove_column :cart_items, :product_id
  end
end
