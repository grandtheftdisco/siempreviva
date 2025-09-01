class AddDeletedAtToCartItems < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :deleted_at, :datetime
  end
end
