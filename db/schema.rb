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

ActiveRecord::Schema[8.1].define(version: 2026_03_18_114811) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

  create_table "documents", force: :cascade do |t|
    t.string "base_path"
    t.uuid "content_store_id", null: false
    t.datetime "created_at", null: false
    t.boolean "draft", default: false, null: false
    t.vector "embedding", limit: 2560
    t.jsonb "taxons", default: []
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxons", force: :cascade do |t|
    t.string "base_path", null: false
    t.uuid "content_store_id", null: false
    t.datetime "created_at", null: false
    t.string "parent_base_path"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end
end
