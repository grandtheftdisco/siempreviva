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

ActiveRecord::Schema[8.0].define(version: 2025_05_22_171527) do
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
    t.text "payment_intent_id", null: false
    t.integer "cart_id", null: false
    t.text "status", null: false
    t.text "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.text "name", null: false
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
