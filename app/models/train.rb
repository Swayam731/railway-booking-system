class Train < ApplicationRecord
  has_many :stops, dependent: :destroy
  has_many :stations, through: :stops
  has_many :tickets, dependent: :destroy
  has_many :journey_classes, dependent: :destroy
  has_many :daily_availabilities, dependent: :destroy
  # has_many :days, dependent: :destroy
  has_and_belongs_to_many :days

  validates :train_name, presence: true
  validates :train_number, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :source_station, presence: true
  validates :destination_station, presence: true
  validates :capacity, presence: true



  def self.search_train(source_station, destination_station, date)
    if source_station.present? && destination_station.present? && date.present?
      source_stops = Stop.where(station_id: source_station.id)
      destination_stop = Stop.where(station_id: destination_station.id)
      trains_from_source_to_destination = []
      source_stops.each do |source_stop|
        stops_after_source = Stop.where(train_id: source_stop.train_id).where('position > ?', source_stop.position)
        destination_stop = stops_after_source.find_by(station_id: destination_station.id)
        if destination_stop
          trains_from_source_to_destination << source_stop.train_id
        end
      end
      @day_name = date&.to_date&.strftime('%A')&.downcase
      @day = Day.find_by(name: @day_name)
      trains_acc_to_day = @day&.trains.where(id: trains_from_source_to_destination).pluck(:id)
      @trains = Train.where(id: trains_acc_to_day)
    else
      @trains = Train.none
    end
  end

  def self.ransackable_associations(auth_object = nil)
    ["days", "journey_classes", "stations", "stops", "tickets", "daily_availabilities"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["capacity", "created_at", "destination_station", "end_time", "id", "id_value", "source_station", "start_time", "train_name", "train_number", "updated_at"]
  end

end
