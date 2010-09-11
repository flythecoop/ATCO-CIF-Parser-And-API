# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def atco_cif
    require 'atco'

    @cif_data = Atco.parse('public/GMA_111_.CIF') # an example data file in the repo

  end
  
  def import_stops
    @path = File.expand_path('public/GMA_111_.CIF')
    data = File.readlines(@path)
    stop_list = []
    
    data.each do |line|
      #logger.info("--- Record Identity: #{line[0,2]}")
      if line[0,2] == 'ZA'
        if !stop_list.include?(line[3,12])
          @bus_stop = BusStop.new
          @bus_stop.ref_code = line[3,12]
          @bus_stop.name = line[15,48]
          @bus_stop.publicity_point = 1 if line[63,2] == 'P1'
          @bus_stop.working_point = 1 if line[63,2] == 'W1'
          @bus_stop.timing_point = 1 if line[63,2] == 'T1'
          @bus_stop.save!
          stop_list << line[3,12] unless stop_list.include?(line[3,12])
        end
      end
    end
    logger.info("--- Stop List: #{stop_list}")
  end
  
  def import_service
    @path = File.expand_path('public/GMA_111_.CIF')
    data = File.readlines(@path)
    
    data.each do |line|
      if line[0,2] == 'ZL'
        @service = Service.new
        @service.reference = line[2,8]
        @service.stop_list_number = line[10,3]
        @service.direction = line[13,1]
      end
      if line[0,2] == 'ZD'
        @service.term_start = line[2,8]
        logger.info("--- Term Start: #{line[2,8]}")
        @service.term_end = line[10,8]
        @service.days_of_operation = line[18,64]
      end
      if line[0,2] == 'ZS'
        @service.number = line[10,4]
        @service.description = line[14,50]
        @service.save!
      end
    end
  end
  
  def import_times
    @files = Dir.glob('public/cif/*')
    @files.each do |file|
      @path = File.expand_path(file)
      data = File.readlines(@path)
      stop_list = []
    
      data.each do |line|      
        if line[0,2] == 'ZL'
          @service = Service.new
          @service.reference = line[2,8]
          @service.stop_list_number = line[10,3]
          @service.direction = line[13,1]
        end
        if line[0,2] == 'ZD'
          @service.term_start = line[2,8]
          @service.term_end = line[10,8]
          @service.days_of_operation = line[18,64]
        end
        if line[0,2] == 'ZS'
          @service.number = line[10,4]
          @service.description = line[14,50]
          @service.save!
          @bus_service = Service.find(:last)
        end
        if line[0,2] == 'ZA'
          if !stop_list.include?(line[3,12])
            @bus_stop = BusStop.new
            @bus_stop.ref_code = line[3,12]
            @bus_stop.name = line[15,48]
            @bus_stop.publicity_point = 1 if line[63,2] == 'P1'
            @bus_stop.working_point = 1 if line[63,2] == 'W1'
            @bus_stop.timing_point = 1 if line[63,2] == 'T1'
            @bus_stop.save!
            stop_list << line[3,12] unless stop_list.include?(line[3,12])
          end
        end
        if line[0,2] == 'QS'
          @journey_detail = JourneyDetail.new
          @journey_detail.service_id = @bus_service.id
          @journey_detail.operator = line[3,4]
          @journey_detail.journey_identifier = line[7,6]
          @journey_detail.monday = 1 if line[29,1] == '1'
          @journey_detail.tuesday = 1 if line[30,1] == '1'
          @journey_detail.wednesday = 1 if line[31,1] == '1'
          @journey_detail.thursday = 1 if line[32,1] == '1'
          @journey_detail.friday = 1 if line[33,1] == '1'
          @journey_detail.saturday = 1 if line[34,1] == '1'
          @journey_detail.sunday = 1 if line[35,1] == '1'
          @journey_detail.school_term = line[36,1]
          @journey_detail.bank_holidays = line[37,1]
        end
        if line[0,2] == 'ZJ'
          @journey_detail.journey_type = line[49,1]
        end
        if line[0,2] == 'ZN'
          @journey_detail.journey_note = line[7,72]
          @journey_detail.save!
          @detail = JourneyDetail.find(:last)
        end
        if line[0,2] == 'QO' && @previous_record_identity == 'ZJ' # if there is no Note Record (ZN) save the @journey_detail
          @journey_detail.save!
          @detail = JourneyDetail.find(:last)
        end
        if line[0,2] == 'QO'
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.bus_stop_id = line[2,12]
          @journey_stop.departure = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.bay_number = line[18,3]
          @journey_stop.save!
          #logger.info("--- Journey Time: #{@journey_stop.inspect}")
        elsif line[0,2] == 'QI'
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.bus_stop_id = line[2,12]
          @journey_stop.arrival = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.departure = "#{line[18,2]}:#{line[20,2]}:00"
          @journey_stop.bay_number = line[23,3]
          @journey_stop.save!
          #logger.info("--- Journey Time: #{@journey_stop.inspect}")
        elsif line[0,2] == 'QT'
          @journey_stop = JourneyStop.new
          @journey_stop.service_id = @bus_service.id
          @journey_stop.journey_detail_id = @detail.id
          @journey_stop.bus_stop_id = line[2,12]
          @journey_stop.arrival = "#{line[14,2]}:#{line[16,2]}:00"
          @journey_stop.bay_number = line[18,3]
          @journey_stop.save!
          #logger.info("--- Journey Time: #{@journey_stop.inspect}")
        end
        @previous_record_identity = line[0,2]
      end
    end
  end
  
  def loop_cif
    @files = Dir.glob('public/cif/*')
  end
end
