class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    earnings = 0
    self.trips.each do |trip|
      earnings += ((trip.cost - 165) * 0.8)
    end
    return earnings
  end
end
