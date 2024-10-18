class RemovePositionFromStations < ActiveRecord::Migration[7.1]
  def change
    remove_column :stations, :position, :integer
  end
end
