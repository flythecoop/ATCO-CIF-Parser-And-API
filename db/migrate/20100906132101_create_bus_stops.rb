class CreateBusStops < ActiveRecord::Migration
  def self.up
    create_table :bus_stops do |t|
      t.string :ref_code
      t.string :name
      t.boolean :publicity_point
      t.boolean :working_point
      t.boolean :timing_point

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_stops
  end
end
