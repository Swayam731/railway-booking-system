class CreateDays < ActiveRecord::Migration[7.1]
  def change
    create_table :days do |t|
      t.string :name
      t.references :train, null: false, foreign_key: true

      t.timestamps
    end
  end
end
