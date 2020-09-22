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

ActiveRecord::Schema.define(version: 2020_09_21_093137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "job"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_participants_on_restaurant_id"
  end

  create_table "permission_lists", force: :cascade do |t|
    t.bigint "list_id"
    t.bigint "permission_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id", "permission_request_id"], name: "index_permission_lists_on_list_id_and_permission_request_id", unique: true
    t.index ["list_id"], name: "index_permission_lists_on_list_id"
    t.index ["permission_request_id"], name: "index_permission_lists_on_permission_request_id"
  end

  create_table "permission_requests", force: :cascade do |t|
    t.integer "sent_from_id"
    t.integer "sent_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["sent_from_id", "sent_to_id"], name: "index_permission_requests_on_sent_from_id_and_sent_to_id", unique: true
    t.index ["sent_from_id"], name: "index_permission_requests_on_sent_from_id"
    t.index ["sent_to_id"], name: "index_permission_requests_on_sent_to_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.bigint "list_id"
    t.integer "price"
    t.text "comment"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "participant"
    t.index ["list_id"], name: "index_restaurants_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lists", "users"
  add_foreign_key "participants", "restaurants"
  add_foreign_key "permission_lists", "lists"
  add_foreign_key "permission_lists", "permission_requests"
  add_foreign_key "restaurants", "lists"
end
