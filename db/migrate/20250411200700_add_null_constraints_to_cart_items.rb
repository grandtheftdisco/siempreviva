class AddNullConstraintsToCartItems < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:cart_items, :price, false)
    change_column_null(:cart_items, :product_id, false)
    change_column_null(:cart_items, :cart_id, false)
  end
end
