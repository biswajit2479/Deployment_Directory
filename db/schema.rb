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

ActiveRecord::Schema.define(version: 20190404170021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clusters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "system_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cluster_id"
    t.integer "csm_info_id"
    t.string "last_updated_by"
  end

  create_table "companies_deployments", id: false, force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "deployment_id"
    t.index ["company_id"], name: "index_companies_deployments_on_company_id"
    t.index ["deployment_id"], name: "index_companies_deployments_on_deployment_id"
  end

  create_table "companies_plugins", id: false, force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "plugin_id"
    t.index ["company_id"], name: "index_companies_plugins_on_company_id"
    t.index ["plugin_id"], name: "index_companies_plugins_on_plugin_id"
  end

  create_table "csm_infos", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deployments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "event_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.string "event_system_name"
    t.date "start_date"
    t.date "end_date"
    t.date "creation_date"
    t.date "purge_date"
    t.string "card_no"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.integer "status_id"
    t.integer "event_type_id"
    t.boolean "purge_status"
    t.string "last_updated_by"
  end

  create_table "events_plugins", id: false, force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "plugin_id"
    t.index ["event_id"], name: "index_events_plugins_on_event_id"
    t.index ["plugin_id"], name: "index_events_plugins_on_plugin_id"
  end

  create_table "plugins", force: :cascade do |t|
    t.string "name"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id"], name: "index_plugins_on_entity_type_and_entity_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.boolean "grant_login_access"
    t.boolean "active_status"
    t.string "email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
