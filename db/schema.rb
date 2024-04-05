# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_01_093314) do
  create_table "dislikes", force: :cascade do |t|
    t.integer "disliker_id", null: false
    t.integer "disliked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disliked_id"], name: "index_dislikes_on_disliked_id"
    t.index ["disliker_id", "disliked_id"], name: "index_dislikes_on_disliker_id_and_disliked_id", unique: true
    t.index ["disliker_id"], name: "index_dislikes_on_disliker_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "liker_id", null: false
    t.integer "liked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liked_id"], name: "index_likes_on_liked_id"
    t.index ["liker_id", "liked_id"], name: "index_likes_on_liker_id_and_liked_id", unique: true
    t.index ["liker_id"], name: "index_likes_on_liker_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_1"
    t.integer "user_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_1", "user_2"], name: "index_matches_on_user_1_and_user_2", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "body"
    t.boolean "seen", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_photos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_user_photos_on_photo_id"
    t.index ["user_id"], name: "index_user_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "email"
    t.date "birthdate"
    t.string "gender"
    t.string "sexual_orientation"
    t.string "gender_interest"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "school"
    t.string "bio"
    t.boolean "is_admin", default: false
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "dislikes", "users", column: "disliked_id"
  add_foreign_key "dislikes", "users", column: "disliker_id"
  add_foreign_key "likes", "users", column: "liked_id"
  add_foreign_key "likes", "users", column: "liker_id"
  add_foreign_key "user_photos", "photos", on_delete: :cascade
  add_foreign_key "user_photos", "users", on_delete: :cascade
end
