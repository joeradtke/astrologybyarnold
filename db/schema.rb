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

ActiveRecord::Schema.define(version: 20150206235310) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "ascendants", force: true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "sign_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspecta", force: true do |t|
    t.integer  "pn"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspectatexts", force: true do |t|
    t.integer  "pn"
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspects", force: true do |t|
    t.integer  "pn1"
    t.integer  "pn2"
    t.string   "name"
    t.string   "p1name"
    t.string   "p2name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspecttexts", force: true do |t|
    t.integer  "pn1"
    t.integer  "pn2"
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "birthplaces", force: true do |t|
    t.string   "city"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "births", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "birthplace_id"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "composites", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "city"
    t.string   "name2"
    t.string   "date2"
    t.string   "city2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "houses", force: true do |t|
    t.string   "name"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "longitude2"
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "natals", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "pay_with"
    t.string   "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "NEW"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "planethouses", force: true do |t|
    t.integer  "planetno"
    t.integer  "houseno"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planets", force: true do |t|
    t.string   "name"
    t.string   "longitude"
    t.string   "house"
    t.string   "sign"
    t.string   "retrograde"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "longitude2"
    t.string   "house2"
    t.string   "longitude3"
  end

  create_table "planetsigns", force: true do |t|
    t.integer  "planetno"
    t.integer  "signno"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "short"
    t.text     "description"
    t.string   "price"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "retrogradetexts", force: true do |t|
    t.integer  "pn"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "synastries", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "city"
    t.string   "name2"
    t.string   "date2"
    t.string   "city2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transitnows", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transits", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "date2"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "username",               default: "",       null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "role",                   default: "member"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
