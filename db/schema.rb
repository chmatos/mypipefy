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

ActiveRecord::Schema.define(version: 20180128200242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", id: :integer, default: nil, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "due_date"
    t.bigint "phase_id"
    t.index ["phase_id"], name: "index_cards_on_phase_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "key"
    t.bigint "phase_id"
    t.bigint "card_id"
    t.string "name"
    t.index ["card_id"], name: "index_fields_on_card_id"
    t.index ["key", "phase_id"], name: "index_fields_on_key_and_phase_id", unique: true
    t.index ["phase_id"], name: "index_fields_on_phase_id"
  end

  create_table "organizations", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
  end

  create_table "phases", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
    t.bigint "pipe_id"
    t.index ["pipe_id"], name: "index_phases_on_pipe_id"
  end

  create_table "pipes", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_pipes_on_organization_id"
  end

  create_table "values", force: :cascade do |t|
    t.string "key"
    t.bigint "card_id"
    t.bigint "phase_id"
    t.string "content"
    t.index ["card_id"], name: "index_values_on_card_id"
    t.index ["phase_id"], name: "index_values_on_phase_id"
  end

  add_foreign_key "cards", "phases"
  add_foreign_key "phases", "pipes"
end
