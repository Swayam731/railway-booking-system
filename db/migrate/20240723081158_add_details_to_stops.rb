class AddDetailsToStops < ActiveRecord::Migration[7.1]
  def change
    add_column :stops, :departure_time, :time
    add_column :stops, :arrival_time, :time
  end
end
