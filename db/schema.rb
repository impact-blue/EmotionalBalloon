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

ActiveRecord::Schema.define(version: 20160113051010) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "balloon_types", force: :cascade do |t|
    t.string   "balloon_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",         limit: 255
  end

  create_table "boxsizes", force: :cascade do |t|
    t.string   "boxsize",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  create_table "carts", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.integer  "product_id", limit: 4
    t.integer  "flag",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "charas", force: :cascade do |t|
    t.string   "chara",      limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "roman",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "color",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  create_table "images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "product_id",        limit: 4
    t.integer  "product_number",    limit: 4
    t.integer  "payment_id",        limit: 4
    t.integer  "user_id",           limit: 4
    t.integer  "city_id",           limit: 4
    t.date     "order_date"
    t.date     "delively_date"
    t.string   "delivery_address",  limit: 255
    t.string   "delivery_address2", limit: 255
    t.string   "option",            limit: 255
    t.integer  "scene_id",          limit: 4
    t.string   "opponent",          limit: 255
    t.string   "order_status",      limit: 255
    t.integer  "price",             limit: 4
    t.integer  "postage",           limit: 4
    t.integer  "commission",        limit: 4
    t.integer  "tax",               limit: 4
    t.integer  "coupon",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "product_balloon_types", force: :cascade do |t|
    t.integer  "product_id",      limit: 4
    t.integer  "balloon_type_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "product_charas", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "chara_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "product_colors", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "color_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "image_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "product_orders", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "product_scenes", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "scene_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image",             limit: 255
    t.integer  "price",             limit: 4
    t.integer  "stocks",            limit: 4
    t.integer  "postage",           limit: 4
    t.text     "comment",           limit: 65535
    t.text     "keyword",           limit: 65535
    t.text     "recommended",       limit: 65535
    t.date     "registration_date"
    t.integer  "boxsize_id",        limit: 4
    t.integer  "number",            limit: 4
  end

  create_table "scenes", force: :cascade do |t|
    t.string   "scene",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "first_name_kana", limit: 255
    t.string   "last_name_kana",  limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 255
    t.integer  "postal_code",     limit: 4
    t.integer  "city_id",         limit: 4
    t.string   "address",         limit: 255
    t.string   "address2",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
