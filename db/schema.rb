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

ActiveRecord::Schema.define(:version => 20130319040816) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["provider"], :name => "index_authorizations_on_provider"

  create_table "extras", :force => true do |t|
    t.integer  "user_id"
    t.string   "special_title"
    t.integer  "experience"
    t.string   "behance"
    t.string   "deviantart"
    t.string   "kongregate"
    t.string   "gamasutra"
    t.string   "newgrounds"
    t.string   "gamejolt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "extras", ["user_id"], :name => "index_extras_on_user_id"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "game_owner"
  end

  add_index "games", ["game_owner"], :name => "index_games_on_game_owner"

  create_table "games_users", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "user_id"
  end

  add_index "games_users", ["game_id", "user_id"], :name => "index_games_users_on_game_id_and_user_id", :unique => true
  add_index "games_users", ["user_id", "game_id"], :name => "index_games_users_on_user_id_and_game_id", :unique => true

  create_table "jobs", :force => true do |t|
    t.string   "jobtitle"
    t.string   "location"
    t.text     "description"
    t.text     "apply_details"
    t.string   "company_name"
    t.string   "company_website"
    t.string   "confirmation_email"
    t.decimal  "salary",              :precision => 10, :scale => 2
    t.string   "jobtype"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.string   "jobkey"
    t.string   "jobkey_confirmation"
    t.integer  "isdeleted"
    t.integer  "category"
    t.boolean  "minimum",                                            :default => false
  end

  add_index "jobs", ["jobkey"], :name => "index_jobs_on_jobkey"
  add_index "jobs", ["jobtitle"], :name => "index_jobs_on_jobtitle"
  add_index "jobs", ["jobtype"], :name => "index_jobs_on_jobtype"
  add_index "jobs", ["location"], :name => "index_jobs_on_location"
  add_index "jobs", ["salary"], :name => "index_jobs_on_salary"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "personal_statement", :limit => 140
    t.string   "image"
    t.string   "location"
    t.string   "job_preference"
    t.integer  "availability"
    t.boolean  "new_user",                          :default => true
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["job_preference"], :name => "index_users_on_job_preference"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["nickname"], :name => "index_users_on_nickname"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_preference"
    t.integer  "user_voted"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["user_voted"], :name => "index_votes_on_user_voted"

end
