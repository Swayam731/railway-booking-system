class AddDistanceToStops < ActiveRecord::Migration[7.1]
  def change
    add_column :stops, :distance, :float, precision: 2
  end
end
