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

ActiveRecord::Schema.define(:version => 20120709132905) do

  create_table "jobs", :force => true do |t|
    t.string   "job_title"
    t.string   "category"
    t.string   "location"
    t.text     "description"
    t.text     "apply_details"
    t.string   "company_name"
    t.string   "company_website"
    t.string   "confirmation_email"
    t.decimal  "salary",             :precision => 10, :scale => 2
    t.string   "job_type"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "jobs", ["category"], :name => "index_jobs_on_category"
  add_index "jobs", ["job_title"], :name => "index_jobs_on_job_title"
  add_index "jobs", ["job_type"], :name => "index_jobs_on_job_type"
  add_index "jobs", ["location"], :name => "index_jobs_on_location"
  add_index "jobs", ["salary"], :name => "index_jobs_on_salary"

end
