class AddNullConstraintsToOrders < ActiveRecord::Migration[8.0]
  def change
    reversible do |dir|
      dir.up do
        change_column_null :orders, :payment_intent_id, false if column_exists?(:orders, :payment_intent_id)
        change_column_null :orders, :cart_id, false if column_exists?(:orders, :cart_id)
        change_column_null :orders, :status, false if column_exists?(:orders, :status)
        change_column_null :orders, :stripe_customer_id, true if column_exists?(:orders, :stripe_customer_id)
      end

      dir.down do
        change_column_null :orders, :payment_intent_id, true if column_exists?(:orders, :payment_intent_id)
        change_column_null :orders, :cart_id, true if column_exists?(:orders, :cart_id)
        change_column_null :orders, :status, true if column_exists?(:orders, :status)
        change_column_null :orders, :stripe_customer_id, false if column_exists?(:orders, :stripe_customer_id)
      end
    end
  end
end
