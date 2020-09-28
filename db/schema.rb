# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_27_232947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "bike_type"
    t.string "size"
    t.string "build"
    t.integer "price"
    t.string "image"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bikes_orders", id: false, force: :cascade do |t|
    t.bigint "bike_id", null: false
    t.bigint "order_id", null: false
    t.index ["bike_id", "order_id"], name: "index_bikes_orders_on_bike_id_and_order_id"
    t.index ["order_id", "bike_id"], name: "index_bikes_orders_on_order_id_and_bike_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "order_total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.text "password_digest"
    t.text "password_cofirmation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
