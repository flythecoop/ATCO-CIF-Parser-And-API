class BusStopsController < ApplicationController
  # GET /bus_stops
  # GET /bus_stops.xml
  def index
    @bus_stops = BusStop.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bus_stops }
    end
  end

  # GET /bus_stops/1
  # GET /bus_stops/1.xml
  def show
    @bus_stop = BusStop.find(:first, :select => "name, ref_code", :conditions => ["ref_code = ?",params[:id]])
    @date = Time.now.localtime.strftime("%Y-%m-%d")
    if params[:service]
      #@ind_services = Service.find(:all, :include => :journey_details, :conditions => ["services.term_start < ? AND (services.term_end > ? OR services.term_end IS NULL) AND journey_details.monday = '1'",@date,@date], :group => 'services.number')
      @services = Service.find(:all, :include => :journey_details, :conditions => ["trim(services.number) = ? AND services.term_start < ? AND (services.term_end > ? OR services.term_end IS NULL) AND journey_details.monday = '1'",params[:service],@date,@date])
      @times = JourneyStop.find(:all, :conditions => ["bus_stop_id = ? AND service_id IN(?)",params[:id],@services])
    else
      @stops = JourneyStop.find(:all, :select => 'service_id', :conditions => ["bus_stop_id = ?",params[:id]], :group => 'service_id')
      @stop_services = []
      @stops.each do |s|
        @stop_services << s.service_id
      end
      @services_at_bus_stop = Service.find(@stop_services)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bus_stop }
    end
  end

  # GET /bus_stops/new
  # GET /bus_stops/new.xml
  def new
    @bus_stop = BusStop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bus_stop }
    end
  end

  # GET /bus_stops/1/edit
  def edit
    @bus_stop = BusStop.find(params[:id])
  end

  # POST /bus_stops
  # POST /bus_stops.xml
  def create
    @bus_stop = BusStop.new(params[:bus_stop])

    respond_to do |format|
      if @bus_stop.save
        flash[:notice] = 'BusStop was successfully created.'
        format.html { redirect_to(@bus_stop) }
        format.xml  { render :xml => @bus_stop, :status => :created, :location => @bus_stop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bus_stop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bus_stops/1
  # PUT /bus_stops/1.xml
  def update
    @bus_stop = BusStop.find(params[:id])

    respond_to do |format|
      if @bus_stop.update_attributes(params[:bus_stop])
        flash[:notice] = 'BusStop was successfully updated.'
        format.html { redirect_to(@bus_stop) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bus_stop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bus_stops/1
  # DELETE /bus_stops/1.xml
  def destroy
    @bus_stop = BusStop.find(params[:id])
    @bus_stop.destroy

    respond_to do |format|
      format.html { redirect_to(bus_stops_url) }
      format.xml  { head :ok }
    end
  end
end
