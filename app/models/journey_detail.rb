class JourneyDetail < ActiveRecord::Base
  belongs_to :service
  has_many :journey_stops
end
