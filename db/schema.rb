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

ActiveRecord::Schema.define(version: 20141205062917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_ownerships", ["account_id"], name: "index_account_ownerships_on_account_id", using: :btree
  add_index "account_ownerships", ["user_id"], name: "index_account_ownerships_on_user_id", using: :btree

  create_table "accounts", force: true do |t|
    t.integer  "school_id"
    t.integer  "balance",    default: 0
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  add_index "accounts", ["school_id"], name: "index_accounts_on_school_id", using: :btree
  add_index "accounts", ["section_id"], name: "index_accounts_on_section_id", using: :btree

  create_table "available_menu_items", force: true do |t|
    t.datetime "date"
    t.integer  "menu_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "available_menu_items", ["menu_item_id"], name: "index_available_menu_items_on_menu_item_id", using: :btree
  add_index "available_menu_items", ["school_id"], name: "index_available_menu_items_on_school_id", using: :btree

  create_table "menu_items", force: true do |t|
    t.integer  "vendor_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["vendor_id"], name: "index_menu_items_on_vendor_id", using: :btree

  create_table "off_days", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "off_days", ["school_id"], name: "index_off_days_on_school_id", using: :btree

  create_table "ordered_items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "available_menu_item_id"
  end

  add_index "ordered_items", ["available_menu_item_id"], name: "index_ordered_items_on_available_menu_item_id", using: :btree
  add_index "ordered_items", ["order_id"], name: "index_ordered_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["account_id"], name: "index_orders_on_account_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "motto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "address"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "section_name"
    t.string   "section_titles"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "vendors", ["school_id"], name: "index_vendors_on_school_id", using: :btree

end
