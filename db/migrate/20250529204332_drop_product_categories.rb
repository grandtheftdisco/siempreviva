class DropProductCategories < ActiveRecord::Migration[8.0]
  def change
    drop_table :product_categories
  end
end
