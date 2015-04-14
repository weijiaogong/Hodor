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

ActiveRecord::Schema.define(:version => 20150408035211) do

  create_table "judges", :force => true do |t|
    t.string "name"
    t.string "company_name"
    t.string "access_code"
  end

  create_table "posters", :force => true do |t|
    t.integer "number"
    t.string  "presenter"
    t.string  "title"
    t.string  "advisors"
  end

  create_table "scores", :force => true do |t|
    t.integer "novelty"
    t.integer "utility"
    t.integer "difficulty"
    t.integer "verbal"
    t.integer "written"
    t.boolean "no_show"
    t.integer "poster_id"
    t.integer "judge_id"
  end

end
