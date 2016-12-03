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

ActiveRecord::Schema.define(version: 20161120221226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "day"
    t.string "month"
    t.string "year"
  end

  create_table "judges", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.string  "company_name",   limit: 255
    t.string  "access_code",    limit: 255
    t.integer "scores_count",               default: 0
    t.string  "remember_token", limit: 255
    t.string  "role",           limit: 255
    t.boolean "leave",                      default: false
    t.index ["remember_token"], name: "index_judges_on_remember_token", using: :btree
  end

  create_table "posters", force: :cascade do |t|
    t.integer "number"
    t.string  "presenter",    limit: 255
    t.string  "title",        limit: 255
    t.string  "advisors",     limit: 255
    t.integer "scores_count",             default: 0
    t.string  "email",        limit: 255
    t.boolean "no_show",                  default: false
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
  end

end
