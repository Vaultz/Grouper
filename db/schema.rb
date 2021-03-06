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

ActiveRecord::Schema.define(version: 20161123161429) do

  create_table "liens", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "year",       limit: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "logo"
  end

  create_table "orals", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_orals_on_project_id"
    t.index ["user_id"], name: "index_orals_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "workshop_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",                                     null: false
    t.string   "lastname",                                      null: false
    t.string   "email",                            default: "", null: false
    t.string   "phone_number"
    t.integer  "status",                           default: 0,  null: false
    t.integer  "year",                   limit: 2,              null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "gender",                                        null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "project_leader"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.string   "name",                     null: false
    t.text     "description",              null: false
    t.integer  "user_id"
    t.string   "teacher",                  null: false
    t.date     "begins",                   null: false
    t.date     "ends",                     null: false
    t.integer  "teamgeneration",           null: false
    t.integer  "teamnumber",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "projectleaders", limit: 1
    t.integer  "year",           limit: 2
    t.string   "slug"
  end

end
