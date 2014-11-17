# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141117162357) do

  create_table "availabilities", force: true do |t|
    t.datetime "date"
    t.integer  "menu_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availabilities", ["menu_item_id"], name: "index_availabilities_on_menu_item_id"

  create_table "menu_items", force: true do |t|
    t.integer  "vendor_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["vendor_id"], name: "index_menu_items_on_vendor_id"

  create_table "orders", force: true do |t|
    t.integer  "menu_item_id"
    t.boolean  "submitted",      default: false
    t.boolean  "paid",           default: false
    t.datetime "submitted_date"
    t.datetime "paid_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["menu_item_id"], name: "index_orders_on_menu_item_id"

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
