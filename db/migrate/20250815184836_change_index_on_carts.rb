class ChangeIndexOnCarts < ActiveRecord::Migration[8.0]
  def change
    remove_index :carts, :session_id
    add_index :carts, [:session_id, :deleted_at], unique: true
  end
end
