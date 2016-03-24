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

ActiveRecord::Schema.define(version: 20160302075410) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "agreements", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_en",    limit: 255
    t.string   "name_ja",    limit: 255
    t.string   "genre",      limit: 255
    t.integer  "status",     limit: 4
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
    t.string   "name_en",    limit: 255
    t.string   "name_ja",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "postal_code",    limit: 255
    t.string   "address",        limit: 255
    t.string   "phone",          limit: 255
    t.string   "ceo",            limit: 255
    t.string   "foundation_day", limit: 255
    t.string   "capital",        limit: 255
    t.string   "trade_name",     limit: 255
    t.string   "proper",         limit: 255
    t.string   "special_price",  limit: 255
    t.string   "cancel_info",    limit: 255
    t.string   "payment_info",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "subject",    limit: 255
    t.text     "content",    limit: 65535
    t.string   "status",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "product_id",         limit: 4
    t.string   "color",              limit: 255
    t.binary   "image",              limit: 16777215
    t.string   "image_content_type", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id", using: :btree

  create_table "mail_contents", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "order_delivery_names", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.string   "order_family_name", limit: 255
    t.string   "order_first_name",  limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "order_delivery_names", ["order_id"], name: "index_order_delivery_names_on_order_id", using: :btree

  create_table "order_product_infos", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "count",      limit: 4
    t.integer  "sum_price",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "order_product_infos", ["order_id", "product_id"], name: "index_order_product_infos_on_order_id_and_product_id", unique: true, using: :btree
  add_index "order_product_infos", ["product_id", "order_id"], name: "index_order_product_infos_on_product_id_and_order_id", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "price",            limit: 4
    t.string   "postal_code",      limit: 255
    t.string   "city",             limit: 255
    t.string   "delivery_address", limit: 255
    t.string   "payment_info",     limit: 255
    t.string   "order_status",     limit: 255
    t.string   "order_sub_status", limit: 255
    t.string   "delivery_phone",   limit: 255
    t.string   "option",           limit: 255
    t.text     "company_memo",     limit: 65535
    t.date     "order_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "product_colors", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "color_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "product_colors", ["color_id", "product_id"], name: "index_product_colors_on_color_id_and_product_id", unique: true, using: :btree
  add_index "product_colors", ["product_id", "color_id"], name: "index_product_colors_on_product_id_and_color_id", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "price",         limit: 4
    t.integer  "stocks",        limit: 4
    t.text     "comment",       limit: 65535
    t.text     "keyword",       limit: 65535
    t.integer  "size",          limit: 4
    t.integer  "count",         limit: 4
    t.integer  "category_id",   limit: 4
    t.integer  "status",        limit: 4
    t.integer  "main_color_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "rankings", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "traderules", force: :cascade do |t|
    t.string   "company",           limit: 255
    t.string   "supervisor",        limit: 255
    t.string   "postal_code",       limit: 255
    t.string   "address",           limit: 255
    t.string   "phone",             limit: 255
    t.string   "business_hours",    limit: 255
    t.string   "mail",              limit: 255
    t.string   "homepage",          limit: 255
    t.string   "price",             limit: 255
    t.string   "special_price",     limit: 255
    t.string   "payment_info",      limit: 255
    t.string   "delivery_deadline", limit: 255
    t.string   "cancel_info",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "user_names", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "user_family_name", limit: 255
    t.string   "user_first_name",  limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "user_names", ["user_id"], name: "index_user_names_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "repeat_count",   limit: 4
    t.integer  "repeat_user_id", limit: 4
    t.string   "name",           limit: 255
    t.string   "email",          limit: 255
    t.string   "customer_phone", limit: 255
    t.string   "postal_code",    limit: 255
    t.string   "city",           limit: 255
    t.string   "address",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
