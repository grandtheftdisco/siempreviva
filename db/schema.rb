ActiveRecord::Schema[8.0].define(version: 2025_06_26_194039) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.integer "price", null: false
    t.integer "cart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1, null: false
    t.text "stripe_product_id", null: false
    t.text "name"
    t.text "image", default: "https://www.blastone.com/wp-content/uploads/image-coming-soon-29.png"
    t.index ["cart_id", "stripe_product_id"], name: "index_cart_items_on_cart_id_and_stripe_product_id", unique: true
  end

  create_table "carts", force: :cascade do |t|
    t.integer "total_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id", null: false
    t.index ["session_id"], name: "index_carts_on_session_id", unique: true
  end

  create_table "checkouts", force: :cascade do |t|
    t.text "payment_intent_id"
    t.integer "cart_id", null: false
    t.text "status", null: false
    t.text "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "stripe_checkout_session_id", null: false
    t.datetime "refunded_on"
  end

  create_table "orders", force: :cascade do |t|
    t.text "payment_intent_id"
    t.text "stripe_customer_id"
    t.text "customer_email_address"
    t.integer "amount"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tracking_number"
    t.datetime "refunded_on"
  end
end
