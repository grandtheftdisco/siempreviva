class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.integer :total_amount

      t.timestamps
    end
  end
end
