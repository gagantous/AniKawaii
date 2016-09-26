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

ActiveRecord::Schema.define(version: 20160926174400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animegifs", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "urlType"
    t.string   "mp4url"
    t.string   "webmurl"
    t.string   "slug"
    t.string   "redditurl"
  end

  create_table "api_dota", force: :cascade do |t|
    t.string   "link"
    t.string   "image"
    t.string   "api_type"
    t.string   "image_thumbnail"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "img"
  end

  create_table "api_lols", force: :cascade do |t|
    t.string   "link"
    t.string   "thumb"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "api_type"
  end

end
