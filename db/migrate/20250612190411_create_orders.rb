class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.text :payment_intent_id
      t.text :stripe_customer_id
      t.text :customer_email_address
      t.integer :amount
      t.text :status

      t.timestamps
    end
  end
end
