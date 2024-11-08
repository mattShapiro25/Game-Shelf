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

ActiveRecord::Schema[7.2].define(version: 2024_11_06_203944) do
  create_table "friends", force: :cascade do |t|
    t.integer "user_id1"
    t.integer "user_id2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "num_players"
    t.integer "num_ratings"
    t.float "avg_rating"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.integer "stars"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_ratings_on_game_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "number_of_ratings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password"
    t.datetime "remember_created_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ratings", "games"
  add_foreign_key "ratings", "users"
end
