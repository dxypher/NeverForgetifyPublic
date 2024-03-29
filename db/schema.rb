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

ActiveRecord::Schema.define(:version => 20120822224033) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "provider"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "notifications", :force => true do |t|
    t.text     "body"
    t.datetime "time"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.datetime "sent_time"
    t.string   "natural_time"
    t.string   "recurring"
    t.boolean  "send_email"
    t.boolean  "send_sms"
    t.boolean  "send_twitter"
    t.boolean  "sent",         :default => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "schedules", :force => true do |t|
    t.datetime "time"
    t.boolean  "sent"
    t.integer  "notification_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.datetime "sent_time"
  end

  add_index "schedules", ["notification_id"], :name => "index_schedules_on_notificaton_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "phone_number"
    t.string   "password"
    t.string   "email"
    t.string   "profile_pic"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "facebook"
    t.integer  "time_zone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "twitter_handle"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
