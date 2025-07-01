# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_01_185942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.integer "price"
    t.integer "product_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "total_amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.index ["session_id"], name: "index_carts_on_session_id", unique: true
  end

  create_table "checkouts", force: :cascade do |t|
    t.text "payment_intent_id"
    t.integer "cart_id", null: false
    t.text "status", null: false
    t.text "stripe_customer_id"
    t.text "stripe_checkout_session_id", null: false
    t.datetime "refunded_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "product_categories", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.text "name", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_category_id"
    t.text "stripe_product_id"
    t.text "stripe_price_id"
    t.text "description"
  end
end
