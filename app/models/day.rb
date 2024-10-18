class Day < ApplicationRecord
  # belongs_to :train
  has_and_belongs_to_many :trains

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "train_id", "updated_at"]
  end
end
