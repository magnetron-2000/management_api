# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_04_150030) do

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "worker_id"
    t.text "state"
    t.date "created_at"
  end

  create_table "workers", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.integer "age"
    t.text "role"
    t.boolean "active", default: true
  end

end
