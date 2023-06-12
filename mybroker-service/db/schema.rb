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

ActiveRecord::Schema[7.0].define(version: 2023_06_08_084154) do
  create_table "nacebels", force: :cascade do |t|
    t.integer "level_nr"
    t.string "code"
    t.string "parent_code"
    t.text "label_nl"
    t.text "label_fr"
    t.text "label_de"
    t.text "label_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requested_quotes", force: :cascade do |t|
    t.integer "subscriber_id", null: false
    t.boolean "natural_person", default: false, null: false
    t.string "enterprise_number", limit: 10, null: false
    t.string "legal_name", null: false
    t.decimal "annual_revenue", precision: 10, scale: 2
    t.string "deductible_formula", default: "medium"
    t.string "coverage_ceiling_formula", default: "small"
    t.text "nacebel_codes", default: "[]", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id"], name: "index_requested_quotes_on_subscriber_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "phone"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
  end

  add_foreign_key "requested_quotes", "subscribers"
end
