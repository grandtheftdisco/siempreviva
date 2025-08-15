class AddDeletedAtToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :deleted_at, :datetime
  end
end
