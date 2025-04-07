class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.integer :price, null: false
      t.integer :category_id

      t.timestamps
    end
  end
end
