class RemoveNullConstraintOnCartTotalAmount < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:carts, :total_amount, true)
  end
end
