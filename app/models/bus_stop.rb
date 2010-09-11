class BusStop < ActiveRecord::Base
  has_many :journey_stops, :class_name => "journey_stop", :foreign_key => "ref_code"
end
