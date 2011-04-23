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

ActiveRecord::Schema.define(:version => 20110421121043) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "task_id"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributors", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributors", ["email"], :name => "index_contributors_on_email", :unique => true
  add_index "contributors", ["reset_password_token"], :name => "index_contributors_on_reset_password_token", :unique => true

  create_table "contributors_projects", :id => false, :force => true do |t|
    t.integer "contributor_id"
    t.integer "project_id"
  end

  create_table "contributors_tasks", :id => false, :force => true do |t|
    t.integer "contributor_id"
    t.integer "task_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "points"
    t.string   "position",    :default => "Backlog"
    t.integer  "category_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
