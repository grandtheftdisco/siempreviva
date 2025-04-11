class AddNullConstraintsToCarts < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:carts, :total_amount, false)
  end
end
