class CreateJourneyStops < ActiveRecord::Migration
  def self.up
    create_table :journey_stops do |t|
      t.integer :service_id
      t.integer :journey_detail_id
      t.string :bus_stop_id
      t.time :arrival
      t.time :departure
      t.string :bay_number

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_stops
  end
end
