class AddProductCategoryIdColumnToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :product_category_id, :integer
  end
end
