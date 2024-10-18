class JourneyClass < ApplicationRecord
  belongs_to :train


  def self.ransackable_attributes(auth_object = nil)
    ["available_seats", "class_code", "class_type", "created_at", "fare", "id", "id_value", "train_id", "updated_at"]
  end

end
