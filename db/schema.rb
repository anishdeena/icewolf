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

ActiveRecord::Schema.define(:version => 20130402083913) do

  create_table "accounts", :force => true do |t|
    t.integer  "provider_type"
    t.string   "unique_id"
    t.integer  "credential_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "articles", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "url"
    t.text     "image_url"
    t.boolean  "deleted"
    t.integer  "credential_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "credentials", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.integer  "account_type"
    t.boolean  "deleted"
    t.string   "fbuid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "friends", :force => true do |t|
    t.string   "name"
    t.integer  "provider_type"
    t.integer  "credential_id"
    t.string   "unique_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "auth_token"
    t.integer  "credential_id"
    t.integer  "session_type"
    t.datetime "last_accessed_at"
    t.boolean  "expired"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "gender"
    t.integer  "credential_id"
    t.integer  "age"
    t.string   "avatar_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
