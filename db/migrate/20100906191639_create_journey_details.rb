class CreateJourneyDetails < ActiveRecord::Migration
  def self.up
    create_table :journey_details do |t|
      t.integer :service_id
      t.string :operator
      t.string :journey_identifier
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.string :school_term
      t.string :bank_holidays
      t.string :journey_type
      t.string :journey_note

      t.timestamps
    end
  end

  def self.down
    drop_table :journey_details
  end
end
