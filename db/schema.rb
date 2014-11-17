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

ActiveRecord::Schema.define(version: 20141117205557) do

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "balance"
    t.string   "name"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["school_id"], name: "index_accounts_on_school_id"
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

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

  create_table "menu_items_orders", id: false, force: true do |t|
    t.integer "menu_items"
    t.integer "orders"
  end

  create_table "off_days", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "off_days", ["school_id"], name: "index_off_days_on_school_id"

  create_table "orders", force: true do |t|
    t.boolean  "submitted",      default: false
    t.boolean  "paid",           default: false
    t.datetime "submitted_date"
    t.datetime "paid_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "school_id"
  end

  add_index "orders", ["school_id"], name: "index_orders_on_school_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "motto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "address"
    t.integer  "user_id"
  end

  add_index "schools", ["user_id"], name: "index_schools_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "vendors", ["school_id"], name: "index_vendors_on_school_id"

end
