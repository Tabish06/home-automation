class ListingsController < ApplicationController
  before_action :logged_in?
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.preload(:devices).where(user_id: current_user.id)
    @listings.each do |listing|
      if listing.token != nil
        # print('here')
        endpoints_uri = 'https://graph.api.smartthings.com/api/smartapps/endpoints'
        # byebug
        response =HTTParty.get(endpoints_uri + '/switches',:headers => { "Authorization" => "Bearer #{listing.token}"})
        # response =HTTParty.put(endpoints_uri + '/switches/off',:headers => { "Authorization" => "Bearer #{listing.token}"})
        
        json = JSON.parse(response.body)
        print(json)
      end
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to [current_user,@listing], notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to [current_user,@listing], notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to user_listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.where(id:params[:id], user_id: current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:address,:client_id,:client_secret, :automation_service,{device_ids: []})
    end
end
