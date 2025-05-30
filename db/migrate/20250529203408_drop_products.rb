class DropProducts < ActiveRecord::Migration[8.0]
  def change
    drop_table :products
  end
end
