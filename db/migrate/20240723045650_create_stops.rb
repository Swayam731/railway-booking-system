class CreateStops < ActiveRecord::Migration[7.1]
  def change
    create_table :stops do |t|
      t.references :train, null: false, foreign_key: true
      t.references :station, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
