class JourneyStop < ActiveRecord::Base
  belongs_to :journey_detail
  belongs_to :bus_stop
  belongs_to :service
end
