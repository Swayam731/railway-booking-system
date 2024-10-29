class Passenger < ApplicationRecord
  belongs_to :ticket

  validates :name, :age, presence: true
  validates :age, numericality: {in: 1..100}
end
