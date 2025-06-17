class RemoveNullConstraintFromPaymentIntentIdInCheckotus < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:checkouts, :payment_intent_id, true)
  end
end
