class CreateJourneyDetails < ActiveRecord::Migration
  def self.up
    create_table :journey_details do |t|
      t.integer :service_id
      t.string :operator, :limit => 4
      t.string :unique_journey_identifier, :limit => 6
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.string :school_term_time, :limit => 1
      t.string :bank_holiday, :limit => 1
      t.string :tendered_commercial, :limit => 1
      t.string :note_text, :limit => 72

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_details
  end
end
