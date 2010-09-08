class Service < ActiveRecord::Base
  has_many :journey_details
  has_many :journey_stops
end
