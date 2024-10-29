class DailyAvailability < ApplicationRecord
  belongs_to :train
  belongs_to :day
  belongs_to :journey_class

  validates :available_seats, numericality: { greater_than_or_equal_to: 0 }
end
