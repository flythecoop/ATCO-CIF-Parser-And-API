class CreateBusStops < ActiveRecord::Migration
  def self.up
    create_table :bus_stops do |t|
      t.string :location_reference, :limit => 12
      t.string :full_location, :limit => 48
      t.boolean :publicity_point_flag
      t.boolean :working_point_flag
      t.boolean :timing_point_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_stops
  end
end
