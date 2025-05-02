class AddNullConstraintToCartSessionId < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:carts, :session_id, false)
  end
end
