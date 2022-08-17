class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @video_game_bookings = Booking.joins(:video_games).where(user_id: current_user)
    @user_video_games = VideoGame.where(user_id: current_user)
  end

  def new
    @offers = Offers.find(params[:video_game_id])
    @booking = Booking.new
  end

  def create
    @offers = Offers.find(params[:video_game_id])
    @booking = Booking.new(booking_params)
    @booking.total_price = total_price
    @booking.user = current_user
    @booking.games = @offers
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index_by_user
    @booking = Booking.where(user_id: current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :user_id, :video_game_id)
  end
end
