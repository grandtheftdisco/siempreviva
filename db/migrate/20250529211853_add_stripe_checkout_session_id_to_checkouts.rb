class AddStripeCheckoutSessionIdToCheckouts < ActiveRecord::Migration[8.0]
  def change
    add_column :checkouts, :stripe_checkout_session_id, :text, null: false
  end
end
