class CreateJourneyStops < ActiveRecord::Migration
  def self.up
    create_table :journey_stops do |t|
      t.integer :service_id
      t.integer :journey_detail_id
      t.string :location, :limit => 12
      t.time :published_arrival_time
      t.time :published_departure_time
      t.string :bay_number, :limit => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_stops
  end
end
