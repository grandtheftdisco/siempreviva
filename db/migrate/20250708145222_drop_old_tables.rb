class DropOldTables < ActiveRecord::Migration[8.0]
  def change
    drop_table :products, if_exists: true
    drop_table :product_categories, if_exists: true
  end
end
