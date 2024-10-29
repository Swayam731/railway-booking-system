class CreateJourneyClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :journey_classes do |t|
      t.string :class_type
      t.string :class_code
      t.float :fare, precision: 2
      t.references :train, null: false, foreign_key: true

      t.timestamps
    end
  end
end
