# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100906191656) do

  create_table "bus_stops", :force => true do |t|
    t.string   "ref_code"
    t.string   "name"
    t.boolean  "publicity_point"
    t.boolean  "working_point"
    t.boolean  "timing_point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journey_details", :force => true do |t|
    t.integer  "service_id"
    t.string   "operator"
    t.string   "journey_identifier"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.string   "school_term"
    t.string   "bank_holidays"
    t.string   "journey_type"
    t.string   "journey_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journey_stops", :force => true do |t|
    t.integer  "service_id"
    t.integer  "journey_detail_id"
    t.string   "bus_stop_id"
    t.time     "arrival"
    t.time     "departure"
    t.string   "bay_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "reference"
    t.string   "stop_list_number"
    t.string   "direction"
    t.date     "term_start"
    t.date     "term_end"
    t.string   "days_of_operation"
    t.string   "number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
