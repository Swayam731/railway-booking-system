class Station < ApplicationRecord
  has_many :stops
  has_many :trains, through: :stops

  def self.ransackable_associations(auth_object = nil)
    ["stops", "trains"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end

end
