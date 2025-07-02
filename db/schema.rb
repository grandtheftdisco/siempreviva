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

ActiveRecord::Schema[8.0].define(version: 2025_07_02_200358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

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

  create_table "sessions", force: :cascade do |t|
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end
end
