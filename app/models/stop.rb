class Stop < ApplicationRecord
  belongs_to :train
  belongs_to :station


  def self.ransackable_attributes(auth_object = nil)
    ["arrival_time", "created_at", "departure_time", "distance", "id", "id_value", "position", "station_id", "train_id", "updated_at"]
  end
end
