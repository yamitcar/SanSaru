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

ActiveRecord::Schema.define(version: 20180213042035) do

  create_table "agile_relations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agiles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "residence", null: false
    t.boolean "first_time", null: false
    t.string "expectancy", null: false
    t.integer "agile_id"
    t.string "agile_description", null: false
    t.string "hobbies"
    t.string "bring"
    t.string "proposal"
    t.string "bio", null: false
    t.integer "agileRelation_id"
    t.integer "gender_id"
    t.integer "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agileRelation_id"], name: "index_profiles_on_agileRelation_id"
    t.index ["agile_id"], name: "index_profiles_on_agile_id"
    t.index ["gender_id"], name: "index_profiles_on_gender_id"
    t.index ["size_id"], name: "index_profiles_on_size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "lastname", null: false
    t.string "email", null: false
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id"], name: "index_users_on_profile_id"
  end

end
