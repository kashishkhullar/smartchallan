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

ActiveRecord::Schema.define(version: 20180324160754) do

  create_table "admin_keys", force: :cascade do |t|
    t.string "admin_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile"
    t.string "admin_key"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_admins_on_authentication_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "challans", force: :cascade do |t|
    t.integer "challantype_id"
    t.date "date_of_issue"
    t.time "time_of_issue"
    t.decimal "latitude"
    t.decimal "longitude"
    t.text "address"
    t.integer "vehicle_id"
    t.integer "trafficpolice_id"
    t.integer "citizen_id"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "paid", default: false
    t.index ["challantype_id"], name: "index_challans_on_challantype_id"
    t.index ["citizen_id"], name: "index_challans_on_citizen_id"
    t.index ["trafficpolice_id"], name: "index_challans_on_trafficpolice_id"
    t.index ["vehicle_id"], name: "index_challans_on_vehicle_id"
  end

  create_table "challantypes", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.string "category"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "citizens", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "aadhar_no"
    t.date "dob"
    t.text "address"
    t.string "authentication_token", limit: 30
    t.integer "commercial_id"
    t.string "dlnumber"
    t.string "pincode"
    t.index ["authentication_token"], name: "index_citizens_on_authentication_token", unique: true
    t.index ["commercial_id"], name: "index_citizens_on_commercial_id"
    t.index ["email"], name: "index_citizens_on_email", unique: true
    t.index ["reset_password_token"], name: "index_citizens_on_reset_password_token", unique: true
  end

  create_table "commercialdrivers", force: :cascade do |t|
    t.integer "commercial_id"
    t.integer "citizen_id"
    t.integer "vehicle_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citizen_id"], name: "index_commercialdrivers_on_citizen_id"
    t.index ["commercial_id"], name: "index_commercialdrivers_on_commercial_id"
    t.index ["vehicle_id"], name: "index_commercialdrivers_on_vehicle_id"
  end

  create_table "commercials", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identification_no"
    t.string "company_name"
    t.string "owner_name"
    t.text "address"
    t.string "mobile"
    t.string "phone_no"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_commercials_on_authentication_token", unique: true
    t.index ["email"], name: "index_commercials_on_email", unique: true
    t.index ["reset_password_token"], name: "index_commercials_on_reset_password_token", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "pollutions", force: :cascade do |t|
    t.string "pollution_no"
    t.date "date_of_issue"
    t.date "date_of_expiry"
    t.text "place_of_issue"
    t.integer "vehicle_id"
    t.integer "citizen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citizen_id"], name: "index_pollutions_on_citizen_id"
    t.index ["vehicle_id"], name: "index_pollutions_on_vehicle_id"
  end

  create_table "trafficpolice_keys", force: :cascade do |t|
    t.string "trafficpolice_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trafficpolices", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "aadhar_no"
    t.date "dob"
    t.text "address"
    t.string "trafficpolice_key"
    t.boolean "registered", default: false
    t.integer "admin_id"
    t.string "authentication_token", limit: 30
    t.index ["admin_id"], name: "index_trafficpolices_on_admin_id"
    t.index ["authentication_token"], name: "index_trafficpolices_on_authentication_token", unique: true
    t.index ["email"], name: "index_trafficpolices_on_email", unique: true
    t.index ["reset_password_token"], name: "index_trafficpolices_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.date "dop"
    t.string "registration_no"
    t.integer "citizen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commercial_id"
    t.index ["citizen_id"], name: "index_vehicles_on_citizen_id"
    t.index ["commercial_id"], name: "index_vehicles_on_commercial_id"
  end

end
