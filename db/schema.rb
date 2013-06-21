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

ActiveRecord::Schema.define(:version => 20130614124128) do

  create_table "articles", :force => true do |t|
    t.string   "cps_id"
    t.string   "headline"
    t.string   "uri"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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

  create_table "programmes", :force => true do |t|
    t.string   "pid"
    t.string   "title"
    t.string   "subtitle"
    t.text     "synopsis"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
