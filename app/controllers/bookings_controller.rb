class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    # @video_game_bookings = Booking.joins(:video_games).where(user_id: current_user)
    # @user_video_games = VideoGame.where(user_id: current_user)
    @bookings = policy_scope(Booking)
  end

  def show
    authorize @booking
  end

  def new
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.new(booking_params)
    # @booking.total_price = total_price
    @booking.offer = @offer
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to bookings_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index_by_user
    @booking = Booking.where(user_id: current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
