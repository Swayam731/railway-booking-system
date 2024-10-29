class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :train
  has_many :passengers, dependent: :destroy

  validates :number_of_passenger, presence: true
  validates :number_of_passenger, numericality: { less_than: 3 }
  validates :date, presence: true
  validate :date_cannot_be_in_past

  # after_update :delete_ticket_if_left_incomplete


  COACH_RULES = {
    "sleeper" => { "S1" => 50...75, "S2" => 25...50, "S3" => 1...25 },
    "first AC" => { "A1" => 50...75, "A2" => 25...50, "A3" => 1...25 },
    "second AC" => { "B1" => 50...75, "B2" => 25...50, "B3" => 1...25 }
  }

  def assign_coach
    COACH_RULES[journey_class]&.each do |coach, range|
      if range.include?(seat_number)
        self.coach_name = coach
        break
      end
    end
  end


  def date_cannot_be_in_past
    if date.present? && date < Date.today
      errors.add(:date, "Please select valid date ")
    end
  end

  def self.decrement_seat_counter(train_id, journey_class, number_of_passenger, date)

    day_name = date.to_date.strftime('%A').downcase
    day = Day.find_by(name: day_name)
    availability = DailyAvailability.find_by(train_id: train_id, journey_class_id: JourneyClass.find_by(train_id: train_id, class_type: journey_class).id, day_id: day.id)

    if availability.available_seats >= number_of_passenger
      availability.update!(available_seats: availability.available_seats - number_of_passenger)
      availability.available_seats
    else
      raise "Not enough seats available"
    end

    # train= JourneyClass.find_by(train_id: train_id, class_type: journey_class)
    # train.update(available_seats: train.available_seats-number_of_passenger)
    # train.available_seats
  end

  def self.calculate_fare(source_station, destination_station, train_id, journey_class)
    source = Station.find_by(name: source_station);
    destination = Station.find_by(name: destination_station);
    distance_of_source = Stop.where(station_id: source.id, train_id: train_id).pick(:distance)
    distance_of_destination = Stop.where(station_id: destination.id, train_id: train_id).pick(:distance)
    total_distance = distance_of_destination-distance_of_source

    fare = JourneyClass.where(train_id: train_id, class_type: journey_class).pick(:fare)

    total_fare = (fare*total_distance)

    total_fare
  end

  def self.ransackable_attributes(auth_object = nil)
    ["coach_name", "created_at", "date", "destination", "fare", "from", "id", "id_value", "journey_class", "number_of_passenger", "seat_number", "source", "to", "train_id", "updated_at", "user_id"]
  end
end
