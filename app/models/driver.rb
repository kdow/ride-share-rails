class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    return self.trips.sum { |trip| (trip.cost - 165) * 0.8 }
  end
end
