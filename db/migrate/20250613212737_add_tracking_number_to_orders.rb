class AddTrackingNumberToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :tracking_number, :text
  end
end
