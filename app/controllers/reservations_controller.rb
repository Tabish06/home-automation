class ReservationsController < ApplicationController
  before_action :logged_in?
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.preload(:listing).joins(:listing).where(listings: {user_id: current_user.id})
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @listing = Listing.where(id: params[:listing_id],user_id: current_user.id).first
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @listing = Listing.where(id: params[:listing_id],user_id: current_user.id).first
    @reservation.listing = @listing
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to [current_user,@listing,@reservation], notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to [current_user,@listing,@reservation], notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.joins(:listing).where(id: params[:id], listings: {user_id: current_user.id}).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:starttime, :endtime)
    end
end
