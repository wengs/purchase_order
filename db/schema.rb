# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160128220817) do

  create_table "activities", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "activities_graphics", force: :cascade do |t|
    t.integer  "activity_id", limit: 4
    t.integer  "graphic_id",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "activities_graphics", ["activity_id", "graphic_id"], name: "index_activities_graphics_on_activity_id_and_graphic_id", unique: true, using: :btree
  add_index "activities_graphics", ["activity_id"], name: "index_activities_graphics_on_activity_id", using: :btree
  add_index "activities_graphics", ["graphic_id"], name: "index_activities_graphics_on_graphic_id", using: :btree

  create_table "activities_pos", force: :cascade do |t|
    t.integer  "activity_id", limit: 4
    t.integer  "po_id",       limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "activities_pos", ["activity_id", "po_id"], name: "index_activities_pos_on_activity_id_and_po_id", unique: true, using: :btree
  add_index "activities_pos", ["activity_id"], name: "index_activities_pos_on_activity_id", using: :btree
  add_index "activities_pos", ["po_id"], name: "index_activities_pos_on_po_id", using: :btree

  create_table "graphic_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "graphics", force: :cascade do |t|
    t.string   "graphic_number",             limit: 255
    t.string   "description",                limit: 255
    t.integer  "quantity",                   limit: 4
    t.decimal  "height",                                   precision: 8, scale: 2
    t.decimal  "width",                                    precision: 8, scale: 2
    t.string   "finishing",                  limit: 255
    t.date     "event_at"
    t.text     "note",                       limit: 65535
    t.string   "location",                   limit: 255
    t.string   "hardware_type",              limit: 255
    t.decimal  "hardware_price",                           precision: 8, scale: 2
    t.boolean  "rush"
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.integer  "user_id",                    limit: 4
    t.integer  "graphic_type_id",            limit: 4
    t.integer  "side_id",                    limit: 4
    t.integer  "substrate_id",               limit: 4
    t.integer  "po_id",                      limit: 4
    t.integer  "number_of_versions",         limit: 4,                             default: 1
    t.boolean  "information_required",                                             default: false
    t.text     "notes_information_required", limit: 65535
    t.boolean  "files_needed",                                                     default: false
    t.text     "notes_files_needed",         limit: 65535
  end

  add_index "graphics", ["graphic_type_id"], name: "index_graphics_on_graphic_type_id", using: :btree
  add_index "graphics", ["po_id"], name: "index_graphics_on_po_id", using: :btree
  add_index "graphics", ["side_id"], name: "index_graphics_on_side_id", using: :btree
  add_index "graphics", ["substrate_id"], name: "index_graphics_on_substrate_id", using: :btree

  create_table "milestones", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pos", force: :cascade do |t|
    t.string   "job_code",                   limit: 255
    t.string   "po_code",                    limit: 255
    t.string   "event_name",                 limit: 255
    t.date     "shipped_at"
    t.datetime "delivered_at"
    t.text     "shipping_instructions",      limit: 65535
    t.decimal  "price",                                    precision: 10, scale: 2
    t.datetime "created_at",                                                                        null: false
    t.datetime "updated_at",                                                                        null: false
    t.integer  "milestone_id",               limit: 4
    t.text     "notes_information_required", limit: 65535
    t.text     "notes_file_needed",          limit: 65535
    t.string   "purchase_order",             limit: 255
    t.string   "quote",                      limit: 255
    t.string   "invoice",                    limit: 255
    t.integer  "user_id",                    limit: 4
    t.string   "tracking_number",            limit: 255
    t.boolean  "ready_for_quote",                                                   default: false
    t.boolean  "information_required",                                              default: false
    t.boolean  "files_needed",                                                      default: false
    t.boolean  "in_production",                                                     default: false
    t.string   "receiver",                   limit: 255
    t.boolean  "graphic_amended",                                                   default: false
    t.text     "notes_production",           limit: 65535
    t.date     "due_date"
    t.boolean  "in_invoicing",                                                      default: false
  end

  add_index "pos", ["milestone_id"], name: "index_pos_on_milestone_id", using: :btree
  add_index "pos", ["user_id"], name: "index_pos_on_user_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "prefix",     limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "sides", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "substrates", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.decimal  "client_cost",             precision: 8, scale: 2
    t.decimal  "our_cost",                precision: 8, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "region_id",              limit: 4
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["region_id"], name: "index_users_on_region_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "activities_graphics", "activities"
  add_foreign_key "activities_graphics", "graphics"
  add_foreign_key "activities_pos", "activities"
  add_foreign_key "activities_pos", "pos"
  add_foreign_key "graphics", "graphic_types"
  add_foreign_key "graphics", "pos"
  add_foreign_key "graphics", "sides"
  add_foreign_key "graphics", "substrates"
  add_foreign_key "pos", "milestones"
  add_foreign_key "pos", "users"
  add_foreign_key "users", "regions"
  add_foreign_key "users", "roles"
end
