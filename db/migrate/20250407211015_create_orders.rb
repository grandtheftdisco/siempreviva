class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.text :payment_intent_id
      t.integer :cart_id
      t.text :status
      t.text :stripe_customer_id

      t.timestamps
    end
  end
end
