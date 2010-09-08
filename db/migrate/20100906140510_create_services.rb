class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :reference
      t.string :stop_list_number
      t.string :direction
      t.date :term_start
      t.date :term_end
      t.string :days_of_operation
      t.string :number
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
