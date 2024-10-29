class RemoveDaysFromTrains < ActiveRecord::Migration[7.1]
  def change
    remove_reference :days, :train, foreign_key: true
  end
end
