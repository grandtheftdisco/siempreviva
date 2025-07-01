class AddSessionIdToCartsAgain < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :session_id, :string unless column_exists?(:carts, :session_id)
    add_index :carts, :session_id, unique: true unless index_exists?(:carts, :session_id)
  end
end
