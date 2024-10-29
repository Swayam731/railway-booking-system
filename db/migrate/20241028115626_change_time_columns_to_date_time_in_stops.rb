class ChangeTimeColumnsToDateTimeInStops < ActiveRecord::Migration[7.1]
  def up
    change_column :stops, :departure_time, :datetime, using: "TIMESTAMP '2000-01-01' + departure_time"
    change_column :stops, :arrival_time, :datetime, using: "TIMESTAMP '2000-01-01' + arrival_time"

    Stop.reset_column_information
    Stop.find_each do |stop|
      stop.update_columns(
        departure_time: stop.created_at.change(hour: stop.departure_time&.hour, min: stop.departure_time&.min),
        arrival_time: stop.created_at.change(hour: stop.arrival_time&.hour, min: stop.arrival_time&.min)
      )
    end
  end

  def down
    change_column :stops, :departure_time, :time
    change_column :stops, :arrival_time, :time
  end
end
