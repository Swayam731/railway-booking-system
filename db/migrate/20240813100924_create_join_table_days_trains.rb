class CreateJoinTableDaysTrains < ActiveRecord::Migration[7.1]
  def change
    create_join_table :days, :trains do |t|
      # t.index [:day_id, :train_id]
      # t.index [:train_id, :day_id]
    end
  end
end
