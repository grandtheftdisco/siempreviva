class AddDefaultToTotalAmountInCartsAgain < ActiveRecord::Migration[8.0]
  def change
    change_column_default :carts, :total_amount, from: nil, to: 0
  end
end
