class CreateTrains < ActiveRecord::Migration[7.1]
  def change
    create_table :trains do |t|
      t.integer :train_number
      t.string :train_name
      t.string :source_station
      t.string :destination_station
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity

      t.timestamps
    end
  end
end
