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

ActiveRecord::Schema[7.1].define(version: 2024_04_11_143210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "test_id", null: false
    t.jsonb "answers_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_answers_on_test_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "test_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "test_id", null: false
    t.jsonb "answers", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_test_results_on_test_id"
    t.index ["user_id"], name: "index_test_results_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "json_contents"
    t.string "types"
    t.index ["name"], name: "index_tests_on_name", unique: true, where: "(name IS NOT NULL)"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "avatar"
    t.boolean "admin", default: false, null: false
    t.string "name", limit: 25, default: "Без имени", null: false
    t.string "last_name", limit: 50, default: "Без фамилии", null: false
    t.index ["admin"], name: "index_users_on_admin", where: "(admin = true)"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
  end

  add_foreign_key "answers", "tests"
  add_foreign_key "answers", "users"
  add_foreign_key "test_results", "tests"
  add_foreign_key "test_results", "users"
end
