class JourneyDetailsController < ApplicationController
  # GET /journey_details
  # GET /journey_details.xml
  def index
    @journey_details = JourneyDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @journey_details }
    end
  end

  # GET /journey_details/1
  # GET /journey_details/1.xml
  def show
    @journey_detail = JourneyDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @journey_detail }
    end
  end

  # GET /journey_details/new
  # GET /journey_details/new.xml
  def new
    @journey_detail = JourneyDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @journey_detail }
    end
  end

  # GET /journey_details/1/edit
  def edit
    @journey_detail = JourneyDetail.find(params[:id])
  end

  # POST /journey_details
  # POST /journey_details.xml
  def create
    @journey_detail = JourneyDetail.new(params[:journey_detail])

    respond_to do |format|
      if @journey_detail.save
        flash[:notice] = 'JourneyDetail was successfully created.'
        format.html { redirect_to(@journey_detail) }
        format.xml  { render :xml => @journey_detail, :status => :created, :location => @journey_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @journey_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /journey_details/1
  # PUT /journey_details/1.xml
  def update
    @journey_detail = JourneyDetail.find(params[:id])

    respond_to do |format|
      if @journey_detail.update_attributes(params[:journey_detail])
        flash[:notice] = 'JourneyDetail was successfully updated.'
        format.html { redirect_to(@journey_detail) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @journey_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /journey_details/1
  # DELETE /journey_details/1.xml
  def destroy
    @journey_detail = JourneyDetail.find(params[:id])
    @journey_detail.destroy

    respond_to do |format|
      format.html { redirect_to(journey_details_url) }
      format.xml  { head :ok }
    end
  end
end
