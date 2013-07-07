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

ActiveRecord::Schema.define(version: 20130707082717) do

  create_table "builds", force: true do |t|
    t.boolean  "status"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "job_id"
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "properties"
  end

  add_index "builds", ["job_id"], name: "index_builds_on_job_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.text     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "builds_count"
  end

end
