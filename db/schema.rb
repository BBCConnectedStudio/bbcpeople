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

ActiveRecord::Schema.define(:version => 20130801090235) do

  create_table "articles", :force => true do |t|
    t.string   "cps_id"
    t.string   "headline"
    t.string   "uri"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "dbpedia_uri"
    t.string   "image_uri"
    t.string   "xpedia_slug"
    t.string   "twitter_handle"
    t.string   "type"
    t.integer  "cooccurence_count", :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.string   "dbpedia_key"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["user_id", "dbpedia_key"], :name => "index_followings_on_user_id_and_dbpedia_key"

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.string   "twitter_handle", :default => "", :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "programmes", :force => true do |t|
    t.string   "pid"
    t.string   "title"
    t.string   "subtitle"
    t.text     "synopsis"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_handle", :default => "", :null => false
    t.string   "provider",       :default => "", :null => false
    t.string   "uid",            :default => "", :null => false
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

end
