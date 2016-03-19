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

ActiveRecord::Schema.define(version: 20160319200400) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "consults", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price"
    t.date     "at_last_price_installed_at"
    t.string   "link_for_pay_from_ukr_card_with_price"
    t.date     "at_last_link_for_pay_from_ukr_card_with_price_installed_at"
    t.string   "ukr_pay_link_without_price"
    t.boolean  "able"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "able"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "price"
    t.date     "at_last_price_installed_at"
    t.string   "link_for_pay_from_ukr_card_with_price"
    t.date     "at_last_link_for_pay_from_ukr_card_with_price_installed_at"
    t.string   "ukr_pay_link_without_price"
    t.string   "name"
    t.string   "translit"
  end

  create_table "order_info_pages", force: :cascade do |t|
    t.text     "msg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "translit"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean  "payed"
    t.string   "name"
    t.string   "email"
    t.string   "cool_time1"
    t.string   "cool_time2"
    t.string   "akey"
    t.string   "pay_way"
    t.string   "end_cards"
    t.decimal  "sum_for_pay"
    t.string   "when_payed"
    t.string   "akey_payed"
    t.boolean  "able",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "number_of_question"
    t.string   "title"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "able",                           default: true
    t.string   "for_yes_answer_plus_1_point_to"
  end

  create_table "tests", force: :cascade do |t|
    t.integer  "number_of_test"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "able",           default: true
  end

end
