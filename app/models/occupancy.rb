class Occupancy < ApplicationRecord
  validates :day, :time, :number, presence: true
  validates :time, numericality: { only_integer: true, greater_than: 0 }

  validates :day, inclusion: { in: %w[Mon Tue Wed Thu Fri Sat Sun] }
  validates :time, inclusion: { in: 1..5 }

  validates :number, uniqueness: { scope: [ :day, :time ] }
end
