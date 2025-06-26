class AddRefundedOnToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :refunded_on, :datetime
  end
end
