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

ActiveRecord::Schema.define(version: 20160131013234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string   "answer"
    t.string   "rating_answer"
    t.string   "selection"
    t.integer  "question_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.boolean  "rating",            default: false
    t.boolean  "multiple_choice"
    t.string   "multiple_choice_1"
    t.string   "multiple_choice_2"
    t.string   "multiple_choice_3"
    t.string   "multiple_choice_4"
    t.string   "multiple_choice_5"
    t.boolean  "require",           default: false
    t.boolean  "text",              default: false
    t.string   "body",                              null: false
    t.integer  "survey_id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveyanswers", force: :cascade do |t|
    t.integer "surveys_id"
    t.integer "answers_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "group"
    t.boolean  "publish",    default: false
    t.integer  "admin_id",                   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
