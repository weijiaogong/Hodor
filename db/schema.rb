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

ActiveRecord::Schema.define(version: 20161203180446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string  "day"
    t.string  "month"
    t.string  "year"
    t.integer "max_poster_number"
  end

  create_table "judges", force: :cascade do |t|
    t.string  "name"
    t.string  "company_name"
    t.string  "access_code"
    t.integer "scores_count",   default: 0
    t.string  "remember_token"
    t.string  "role"
    t.index ["remember_token"], name: "index_judges_on_remember_token", using: :btree
  end

  create_table "posters", force: :cascade do |t|
    t.integer "number"
    t.string  "presenter"
    t.string  "title"
    t.string  "advisors"
    t.integer "scores_count", default: 0
    t.string  "email"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "novelty"
    t.integer "utility"
    t.integer "difficulty"
    t.integer "verbal"
    t.integer "written"
    t.integer "poster_id"
    t.integer "judge_id"
    t.boolean "no_show",    default: false
    t.index ["judge_id"], name: "index_scores_on_judge_id", using: :btree
    t.index ["poster_id"], name: "index_scores_on_poster_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

end
