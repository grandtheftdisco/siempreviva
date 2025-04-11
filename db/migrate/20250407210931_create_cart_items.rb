class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :price
      t.integer :product_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
