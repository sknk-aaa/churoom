class Occupancy < ApplicationRecord
  validates :day, :time, :number, presence: true
  validates :time, numericality: { only_integer: true, greater_than: 0 }
end
