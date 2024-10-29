class Day < ApplicationRecord
  # belongs_to :train
  has_and_belongs_to_many :trains
  has_many :daily_availabilities, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "train_id", "updated_at"]
  end

  # def self.ransackable_associations(auth_object = nil)
  #   ["daily_availabilities"]
  # end
end
