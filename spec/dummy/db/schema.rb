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

ActiveRecord::Schema.define(version: 20150223145759) do

  create_table "celebrities", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.integer "gender"
    t.date    "birth_date"
  end

  create_table "samsara_contexts", force: :cascade do |t|
    t.string   "event_type"
    t.text     "event_attributes"
    t.string   "environment_name"
    t.string   "application_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samsara_revisions", force: :cascade do |t|
    t.string   "action"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.text     "modified_attributes"
    t.text     "original_attributes"
    t.integer  "context_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samsara_revisions", ["context_id"], name: "index_samsara_revisions_on_context_id"

end
