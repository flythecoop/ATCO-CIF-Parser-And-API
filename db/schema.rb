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

ActiveRecord::Schema.define(:version => 20100920182052) do

  create_table "bus_stops", :force => true do |t|
    t.string   "location_reference",   :limit => 12
    t.string   "full_location",        :limit => 48
    t.boolean  "publicity_point_flag"
    t.boolean  "working_point_flag"
    t.boolean  "timing_point_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journey_details", :force => true do |t|
    t.integer  "service_id"
    t.string   "operator",                  :limit => 4
    t.string   "unique_journey_identifier", :limit => 6
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.string   "school_term_time",          :limit => 1
    t.string   "bank_holiday",              :limit => 1
    t.string   "tendered_commercial",       :limit => 1
    t.string   "note_text",                 :limit => 72
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journey_stops", :force => true do |t|
    t.integer  "service_id"
    t.integer  "journey_detail_id"
    t.string   "location",                 :limit => 12
    t.time     "published_arrival_time"
    t.time     "published_departure_time"
    t.string   "bay_number",               :limit => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "service_reference",   :limit => 8
    t.string   "stop_list_number",    :limit => 3
    t.string   "direction_of_travel", :limit => 1
    t.date     "start_date"
    t.date     "last_date"
    t.string   "days_of_operation",   :limit => 64
    t.string   "service_number",      :limit => 4
    t.string   "description",         :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
