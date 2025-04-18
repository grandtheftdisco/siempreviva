class AddDefaultToTotalAmountInCarts < ActiveRecord::Migration[8.0]
  def change
    change_column_default :carts, :total_amount, 0
  end
end
