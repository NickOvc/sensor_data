class Sensor < ApplicationRecord
  has_many :sensor_data

  validates :name, :location, :device, :location_max_capacity, presence: true
  validates :external_id,
    presence: { message: "_id can't be blank." },
    uniqueness: { message: "_id must be unique." }
end
