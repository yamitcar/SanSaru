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

ActiveRecord::Schema.define(version: 2019_07_22_105999) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

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

  create_table "custom_emails", force: :cascade do |t|
    t.string "name", null: false
    t.string "copy_to", null: false
    t.text "template", null: false
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_custom_emails_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "fullname", null: false
    t.string "site", null: false
    t.string "support_mail", null: false
    t.integer "participants", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.decimal "reserve_price", precision: 8, scale: 2
    t.decimal "ideal_price", precision: 8, scale: 2
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "venue", null: false
    t.string "venue_location", null: false
    t.string "monkeys", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "activo"
    t.integer "tickets_left"
  end

  create_table "favorites", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "favorite_user_id"
    t.index ["favorite_user_id", "user_id"], name: "index_favorites_on_favorite_user_id_and_user_id", unique: true
    t.index ["user_id", "favorite_user_id"], name: "index_favorites_on_user_id_and_favorite_user_id", unique: true
  end

  create_table "genders", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "invited_one_id"
    t.bigint "invited_two_id"
    t.datetime "one_on"
    t.datetime "two_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "monkey", default: false
    t.boolean "payed", default: false
    t.index ["invited_one_id"], name: "index_invitations_on_invited_one_id"
    t.index ["invited_two_id"], name: "index_invitations_on_invited_two_id"
    t.index ["user_id"], name: "index_invitations_on_user_id", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.string "path"
    t.text "content"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_pages_on_event_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.boolean "first_time", null: false
    t.string "expectancy", null: false
    t.bigint "agile_id"
    t.string "agile_description", null: false
    t.string "hobbies"
    t.string "bring"
    t.string "proposal"
    t.string "bio", null: false
    t.bigint "agileRelation_id"
    t.bigint "gender_id"
    t.bigint "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country", default: "", null: false
    t.string "state", default: "", null: false
    t.string "city", default: "", null: false
    t.string "phonenumber", default: "", null: false
    t.string "telegram"
    t.integer "user_id"
    t.integer "event_id"
    t.boolean "organizer", default: false, null: false
    t.boolean "need_mentor", default: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "terms_of_service", default: false
    t.integer "actual_event_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "invitations", "users"
  add_foreign_key "profiles", "events"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "events", column: "actual_event_id"
end
