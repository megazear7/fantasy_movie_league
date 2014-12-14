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

ActiveRecord::Schema.define(version: 20141214011548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friend_requests", force: true do |t|
    t.integer "requester_id",                                                   null: false
    t.integer "requestee_id",                                                   null: false
    t.text    "message",      default: "Hello, would you like to share stats?"
    t.boolean "active",       default: true
  end

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
  end

  create_table "movies", force: true do |t|
    t.string   "name",                          null: false
    t.integer  "box_office_actual", default: 0, null: false
    t.date     "release",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rosters", force: true do |t|
    t.integer  "user_id",                            null: false
    t.integer  "season_id",                          null: false
    t.integer  "movie_one_id"
    t.integer  "movie_two_id"
    t.integer  "movie_three_id"
    t.integer  "movie_four_id"
    t.integer  "movie_five_id"
    t.integer  "movie_six_id"
    t.integer  "movie_seven_id"
    t.integer  "movie_eight_id"
    t.integer  "movie_nine_id"
    t.integer  "movie_ten_id"
    t.integer  "darkhorse_one_id"
    t.integer  "darkhorse_two_id"
    t.integer  "darkhorse_three_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finalized",          default: false
    t.integer  "final_score",        default: 0
  end

  create_table "season_requests", force: true do |t|
    t.integer "season_id"
    t.integer "requester_id",                                                            null: false
    t.integer "requestee_id",                                                            null: false
    t.text    "message",      default: "Hello, would you like to compete in my league?"
    t.boolean "active",       default: true
  end

  create_table "seasons", force: true do |t|
    t.date     "begin_date", default: '2014-12-12', null: false
    t.date     "end_date",   default: '2015-06-12', null: false
    t.string   "name",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "finalized",  default: false
    t.boolean  "has_ended",  default: false
  end

  create_table "users", force: true do |t|
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
    t.integer  "admin_level",            default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
