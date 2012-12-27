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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121227220303) do

  create_table "boxes", :force => true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "master_meat_id"
    t.integer  "user_id"
    t.boolean  "active"
  end

  create_table "data_points", :force => true do |t|
    t.string   "data_type"
    t.float    "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "box_id"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.decimal  "water_percentage"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "meats", :force => true do |t|
    t.string   "name"
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "box_id"
    t.decimal  "initial_weight"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.decimal  "goal_weight"
    t.decimal  "initial_water_weight"
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.string   "name"
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.decimal  "recipe_weight_percentage"
    t.decimal  "water_percentage"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "team_id"
    t.decimal  "initial_water_percentage"
    t.boolean  "fermented"
    t.integer  "approximate_diameter"
    t.integer  "expected_curing_time"
    t.integer  "expected_fermenting_time"
    t.integer  "expected_drying_time"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "teammates", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "api_key"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
