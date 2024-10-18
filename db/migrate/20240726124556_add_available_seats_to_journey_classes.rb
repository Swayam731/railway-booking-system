class AddAvailableSeatsToJourneyClasses < ActiveRecord::Migration[7.1]
  def change
    add_column :journey_classes, :available_seats, :integer
  end
end
