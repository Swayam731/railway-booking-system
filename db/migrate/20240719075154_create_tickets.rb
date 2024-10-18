class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :from
      t.string :to
      t.string :journey_class
      t.string :coach_name
      t.integer :seat_number
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true

      t.timestamps
    end
  end
end
