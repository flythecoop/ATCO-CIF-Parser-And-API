class JourneyStopsController < ApplicationController
  # GET /journey_stops
  # GET /journey_stops.xml
  def index
    @journey_stops = JourneyStop.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @journey_stops }
    end
  end

  # GET /journey_stops/1
  # GET /journey_stops/1.xml
  def show
    @journey_stop = JourneyStop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @journey_stop }
    end
  end

  # GET /journey_stops/new
  # GET /journey_stops/new.xml
  def new
    @journey_stop = JourneyStop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @journey_stop }
    end
  end

  # GET /journey_stops/1/edit
  def edit
    @journey_stop = JourneyStop.find(params[:id])
  end

  # POST /journey_stops
  # POST /journey_stops.xml
  def create
    @journey_stop = JourneyStop.new(params[:journey_stop])

    respond_to do |format|
      if @journey_stop.save
        format.html { redirect_to(@journey_stop, :notice => 'Journey stop was successfully created.') }
        format.xml  { render :xml => @journey_stop, :status => :created, :location => @journey_stop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @journey_stop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /journey_stops/1
  # PUT /journey_stops/1.xml
  def update
    @journey_stop = JourneyStop.find(params[:id])

    respond_to do |format|
      if @journey_stop.update_attributes(params[:journey_stop])
        format.html { redirect_to(@journey_stop, :notice => 'Journey stop was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @journey_stop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /journey_stops/1
  # DELETE /journey_stops/1.xml
  def destroy
    @journey_stop = JourneyStop.find(params[:id])
    @journey_stop.destroy

    respond_to do |format|
      format.html { redirect_to(journey_stops_url) }
      format.xml  { head :ok }
    end
  end
end
