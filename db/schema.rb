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

ActiveRecord::Schema.define(version: 20160902065949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "comments_count",   default: 0
    t.integer  "up",               default: 0
    t.integer  "down",             default: 0
    t.integer  "hotness",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "flags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.integer  "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["flaggable_id", "flaggable_type"], name: "index_flags_on_flaggable_id_and_flaggable_type", using: :btree
  add_index "flags", ["user_id"], name: "index_flags_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "proposal_id"
    t.integer  "action"
    t.integer  "recipient_id"
    t.integer  "user_id"
    t.boolean  "seen",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "theme_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "comments_count", default: 0
    t.boolean  "approved",       default: false
    t.integer  "up",             default: 0
    t.integer  "down",           default: 0
    t.integer  "hotness",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proposals", ["theme_id"], name: "index_proposals_on_theme_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.integer  "proposal_id"
    t.integer  "kind"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["proposal_id"], name: "index_statuses_on_proposal_id", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.integer  "user_id"
    t.integer  "proposals_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",        default: false
    t.text     "long_info"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "role",                   default: 0
    t.integer  "reputation",             default: 0
    t.integer  "comments_rank",          default: 0
    t.integer  "proposals_rank",         default: 0
    t.text     "bio"
    t.string   "api_token"
    t.boolean  "subscribed",             default: false, null: false
    t.boolean  "banned",                 default: false, null: false
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votings", ["user_id"], name: "index_votings_on_user_id", using: :btree
  add_index "votings", ["votable_id", "votable_type"], name: "index_votings_on_votable_id_and_votable_type", using: :btree

end
