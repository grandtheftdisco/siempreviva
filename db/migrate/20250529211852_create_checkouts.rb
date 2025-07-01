class CreateCheckouts < ActiveRecord::Migration[8.0]
  def change
    create_table :checkouts do |t|
      t.text :payment_intent_id
      t.integer :cart_id, null: false
      t.text :status, null: false
      t.text :stripe_customer_id
      t.text :stripe_checkout_session_id, null: false
      t.datetime :refunded_on

      t.timestamps
    end
  end
end
