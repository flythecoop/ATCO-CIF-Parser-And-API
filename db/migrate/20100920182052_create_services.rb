class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :service_reference, :limit => 8
      t.string :stop_list_number, :limit => 3
      t.string :direction_of_travel, :limit => 1
      t.date :start_date
      t.date :last_date
      t.string :days_of_operation, :limit => 64
      t.string :service_number, :limit => 4
      t.string :description, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
