class CreateProductCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :product_categories do |t|
      t.text :name

      t.timestamps
    end
  end
end
