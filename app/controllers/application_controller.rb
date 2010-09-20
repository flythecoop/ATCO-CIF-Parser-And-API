class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def import_times
    @files = Dir.glob('public/cif/*')
    stop_list = []
    @files.each do |file|
      @path = File.expand_path(file)
      data = File.readlines(@path)
    
      data.each do |line|      
        if line[0,2] == 'ZL' # Timetable Stop List record
          @service = Service.new
          @service.service_reference = line[2,8]
          @service.stop_list_number = line[10,3]
          @service.direction_of_travel = line[13,1]
        end
        if line[0,2] == 'ZD' # Timetable Date record
          @service.start_date = line[2,8]
          @service.last_date = line[10,8]
          @service.days_of_operation = line[18,64]
        end
        if line[0,2] == 'ZS' # Service Details record
          @service.service_number = line[10,4]
          @service.description = line[14,50]
          @service.save
          @bus_service = Service.last
        end
        if line[0,2] == 'ZA' # Timetable Row List Entries
          if !stop_list.include?(line[3,12])
            @bus_stop = BusStop.new
            @bus_stop.location_reference = line[3,12]
            @bus_stop.full_location = line[15,48]
            @bus_stop.publicity_point_flag = 1 if line[63,2] == 'P1'
            @bus_stop.working_point_flag = 1 if line[65,2] == 'W1'
            @bus_stop.timing_point_flag = 1 if line[67,2] == 'T1'
            @bus_stop.save
            stop_list << line[3,12] unless stop_list.include?(line[3,12])
          end
        end
        if line[0,2] == 'QS' # Journey Header
          @journey_detail = JourneyDetail.new
          @journey_detail.service_id = @bus_service.id
          @journey_detail.operator = line[3,4]
          @journey_detail.unique_journey_identifier = line[7,6]
          @journey_detail.monday = 1 if line[29,1] == '1'
          @journey_detail.tuesday = 1 if line[30,1] == '1'
          @journey_detail.wednesday = 1 if line[31,1] == '1'
          @journey_detail.thursday = 1 if line[32,1] == '1'
          @journey_detail.friday = 1 if line[33,1] == '1'
          @journey_detail.saturday = 1 if line[34,1] == '1'
          @journey_detail.sunday = 1 if line[35,1] == '1'
          @journey_detail.school_term_time = line[36,1]
          @journey_detail.bank_holiday = line[37,1]
        end
        if line[0,2] == 'ZJ' # Journey Additional Details record
          @journey_detail.tendered_commercial = line[49,1]
        end
        if line[0,2] == 'ZN' # Note record
          @journey_detail.note_text = line[7,72]
          @journey_detail.save
          @detail = JourneyDetail.last
        end
        if line[0,2] == 'QO' && @previous_record_identity == 'ZJ' # if there is no Note Record (ZN) save the @journey_detail
          @journey_detail.save
          @detail = JourneyDetail.last
        end
        if line[0,2] == 'QO' # Origin Record
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.location = line[2,12]
          @journey_stop.published_departure_time = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.bay_number = line[18,3]
          @journey_stop.save
        elsif line[0,2] == 'QI' # Intermediate Record
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.location = line[2,12]
          @journey_stop.published_arrival_time = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.published_departure_time = "#{line[18,2]}:#{line[20,2]}:00"
          @journey_stop.bay_number = line[23,3]
          @journey_stop.save
        elsif line[0,2] == 'QT' # Destination Record
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.location = line[2,12]
          @journey_stop.published_arrival_time = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.bay_number = line[18,3]
          @journey_stop.save
        end
        @previous_record_identity = line[0,2]
      end
    end
  end
end
