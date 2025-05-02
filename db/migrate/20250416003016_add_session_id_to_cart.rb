class AddSessionIdToCart < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :session_id, :string
    add_index :carts, :session_id, unique: true
  end
end
