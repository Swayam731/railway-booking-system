class CreateDailyAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_availabilities do |t|
      t.integer :available_seats
      t.references :train, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true
      t.references :journey_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end
