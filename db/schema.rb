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

ActiveRecord::Schema.define(version: 20141117165004) do

  create_table "menu_items", force: true do |t|
    t.integer  "vendor_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["vendor_id"], name: "index_menu_items_on_vendor_id"

  create_table "off_days", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "off_days", ["school_id"], name: "index_off_days_on_school_id"

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "motto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "address"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

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
