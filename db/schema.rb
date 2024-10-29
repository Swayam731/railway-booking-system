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

ActiveRecord::Schema[7.1].define(version: 2024_10_28_115626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "daily_availabilities", force: :cascade do |t|
    t.integer "available_seats"
    t.bigint "train_id", null: false
    t.bigint "day_id", null: false
    t.bigint "journey_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_daily_availabilities_on_day_id"
    t.index ["journey_class_id"], name: "index_daily_availabilities_on_journey_class_id"
    t.index ["train_id"], name: "index_daily_availabilities_on_train_id"
  end

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days_trains", id: false, force: :cascade do |t|
    t.bigint "day_id", null: false
    t.bigint "train_id", null: false
  end

  create_table "journey_classes", force: :cascade do |t|
    t.string "class_type"
    t.string "class_code"
    t.float "fare"
    t.bigint "train_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "available_seats"
    t.index ["train_id"], name: "index_journey_classes_on_train_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name2"
    t.integer "age2"
    t.index ["ticket_id"], name: "index_passengers_on_ticket_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.bigint "train_id", null: false
    t.bigint "station_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.float "distance"
    t.index ["station_id"], name: "index_stops_on_station_id"
    t.index ["train_id"], name: "index_stops_on_train_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "journey_class"
    t.string "coach_name"
    t.integer "seat_number"
    t.datetime "date"
    t.bigint "user_id", null: false
    t.bigint "train_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_passenger"
    t.string "source"
    t.string "destination"
    t.float "fare"
    t.index ["train_id"], name: "index_tickets_on_train_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "trains", force: :cascade do |t|
    t.integer "train_number"
    t.string "train_name"
    t.string "source_station"
    t.string "destination_station"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_availabilities", "days"
  add_foreign_key "daily_availabilities", "journey_classes"
  add_foreign_key "daily_availabilities", "trains"
  add_foreign_key "journey_classes", "trains"
  add_foreign_key "passengers", "tickets"
  add_foreign_key "stops", "stations"
  add_foreign_key "stops", "trains"
  add_foreign_key "tickets", "trains"
  add_foreign_key "tickets", "users"
end
