class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify

  validates :name, presence: true
  validates :phone_num, presence: true

  def total_charged
    return self.trips.sum(&:cost)
  end
end
