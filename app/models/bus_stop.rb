class BusStop < ActiveRecord::Base
  has_many :journey_stops
end
