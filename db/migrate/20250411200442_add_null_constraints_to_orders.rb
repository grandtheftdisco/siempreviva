class AddNullConstraintsToOrders < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:orders, :payment_intent_id, false)
    change_column_null(:orders, :cart_id, false)
    change_column_null(:orders, :status, false)
    change_column_null(:orders, :stripe_customer_id, true)
  end
end
