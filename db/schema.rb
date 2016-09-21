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

ActiveRecord::Schema.define(version: 20160921081844) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "budget_id"
    t.string   "name"
    t.integer  "amount"
    t.integer  "balance",    default: 0
    t.boolean  "default",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["budget_id"], name: "index_accounts_on_budget_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "login_id"
    t.string   "name"
    t.datetime "sync_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_id"], name: "index_bank_accounts_on_login_id"
  end

  create_table "bank_logins", force: :cascade do |t|
    t.integer  "budget_id"
    t.text     "credentials"
    t.string   "adapter_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["budget_id"], name: "index_bank_logins_on_budget_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "first_pay_day"
    t.string   "cycle_length"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "pay_days", force: :cascade do |t|
    t.integer  "budget_id"
    t.date     "effective_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["budget_id"], name: "index_pay_days_on_budget_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "description"
    t.datetime "effective_date"
    t.integer  "amount"
    t.string   "type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["source_type", "source_id"], name: "index_transactions_on_source_type_and_source_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
