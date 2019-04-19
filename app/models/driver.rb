class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    return self.trips.sum { |trip| (trip.cost - 165) * 0.8 }
  end

  def average_rating
    total = 0
    count = 0
    self.trips.each do |trip|
      if trip.rating
        total += trip.rating
        count += 1
      end
    end
    if count == 0
      return "This driver has no ratings"
    else
      return total / count
    end
  end

  def go_available
    return self.available = true
  end

  def go_unavailable
    return self.available = false
  end
end
