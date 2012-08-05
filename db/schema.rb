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

ActiveRecord::Schema.define(:version => 20120803192654) do

  create_table "appointment_services", :force => true do |t|
    t.integer  "appointment_id"
    t.integer  "service_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "appointment_services", ["appointment_id"], :name => "index_appointment_services_on_appointment_id"
  add_index "appointment_services", ["service_id"], :name => "index_appointment_services_on_service_id"

  create_table "appointments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "start"
    t.datetime "finish"
    t.string   "duration"
    t.string   "location"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "appointments", ["contact_id"], :name => "index_appointments_on_contact_id"
  add_index "appointments", ["user_id"], :name => "index_appointments_on_user_id"

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "per_page"
    t.string   "allow_comments"
    t.integer  "per_comments"
    t.boolean  "recent"
    t.boolean  "tag_cloud"
    t.boolean  "categories"
    t.boolean  "archive"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "blogs", ["user_id"], :name => "index_blogs_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.string   "message"
    t.string   "theme"
    t.string   "recipients"
    t.string   "attachements"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "contact_messages", ["user_id"], :name => "index_contact_messages_on_user_id"

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

  create_table "news_messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "message"
    t.string   "theme"
    t.string   "attachements"
    t.boolean  "business"
    t.boolean  "subscribers"
    t.boolean  "clients"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "news_messages", ["user_id"], :name => "index_news_messages_on_user_id"

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

  create_table "post_categories", :force => true do |t|
    t.integer "post_id"
    t.integer "category_id"
  end

  add_index "post_categories", ["category_id"], :name => "index_post_categories_on_category_id"
  add_index "post_categories", ["post_id"], :name => "index_post_categories_on_post_id"

  create_table "post_tags", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_tags", ["post_id"], :name => "index_post_tags_on_post_id"
  add_index "post_tags", ["tag_id"], :name => "index_post_tags_on_tag_id"

  create_table "posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title"
    t.text     "content"
    t.string   "ptype"
    t.string   "image"
    t.string   "block_quote"
    t.string   "q_author"
    t.string   "href"
    t.string   "link_text"
    t.string   "video"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "posts", ["blog_id"], :name => "index_posts_on_blog_id"

  create_table "prerequisite_relationships", :force => true do |t|
    t.integer  "main_id"
    t.integer  "service_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "prerequisite_relationships", ["main_id"], :name => "index_prerequisite_relationships_on_main_id"
  add_index "prerequisite_relationships", ["service_id"], :name => "index_prerequisite_relationships_on_service_id"

  create_table "schedules", :force => true do |t|
    t.integer  "user_id"
    t.string   "schedule"
    t.integer  "padding"
    t.boolean  "online"
    t.boolean  "contact_only"
    t.boolean  "user_email"
    t.boolean  "contact_email"
    t.string   "confirmation"
    t.integer  "send_reminder"
    t.string   "reminder"
    t.boolean  "cap_name"
    t.boolean  "cap_email"
    t.boolean  "cap_phone"
    t.boolean  "cap_address"
    t.boolean  "outcall"
    t.boolean  "office"
    t.string   "office_location"
    t.boolean  "cancellation"
    t.integer  "cancellation_time"
    t.string   "cancellation_policy"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "timezone"
  end

  add_index "schedules", ["user_id"], :name => "index_schedules_on_user_id"

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "main"
    t.string   "name"
    t.string   "description"
    t.string   "available"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
