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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120718214619) do

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_l1"
    t.string   "address_l2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "secondary_email"
    t.string   "business"
    t.date     "birth_date"
    t.string   "ctype"
    t.boolean  "email_list"
    t.datetime "opt_in"
    t.string   "created_from"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "alt"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "profile"
    t.boolean  "logo"
  end

  create_table "pages", :force => true do |t|
    t.integer  "website_id"
    t.boolean  "indexed",    :default => true
    t.text     "content"
    t.string   "ptype",      :default => "Normal"
    t.boolean  "child",      :default => false
    t.string   "ptitle"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.string   "last_name",              :limit => 60
    t.string   "address_l1",             :limit => 60
    t.string   "address_l2",             :limit => 60
    t.string   "city",                   :limit => 60
    t.string   "state",                  :limit => 60
    t.string   "zip",                    :limit => 12
    t.string   "telephone",              :limit => 12
    t.string   "business",               :limit => 60
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "activated"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "websites", :force => true do |t|
    t.string   "user_id"
    t.string   "theme"
    t.string   "domain"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "title",       :limit => 60
    t.string   "motto",       :limit => 60
    t.string   "order"
    t.string   "description"
    t.string   "keywords"
  end

end
