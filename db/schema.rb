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

ActiveRecord::Schema.define(version: 20161108032138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "day"
    t.string "month"
    t.string "year"
  end

  create_table "judges", force: :cascade do |t|
    t.string  "name"
    t.string  "company_name"
    t.string  "access_code"
    t.integer "scores_count",   default: 0
    t.string  "remember_token"
    t.string  "role"
    t.boolean "leave",          default: false
    t.index ["remember_token"], name: "index_judges_on_remember_token", using: :btree
  end

  create_table "posters", force: :cascade do |t|
    t.integer "number"
    t.string  "presenter"
    t.string  "title"
    t.string  "advisors"
    t.integer "scores_count", default: 0
    t.string  "email"
    t.boolean "no_show",      default: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "novelty"
    t.integer "utility"
    t.integer "difficulty"
    t.integer "verbal"
    t.integer "written"
    t.integer "poster_id"
    t.integer "judge_id"
    t.index ["judge_id"], name: "index_scores_on_judge_id", using: :btree
    t.index ["poster_id"], name: "index_scores_on_poster_id", using: :btree
  end

end
