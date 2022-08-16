class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user)
    @game_bookings = Booking.joins(:games).where(user_id: current_user)
    @user_games = Games.where(user_id: current_user)
  end

  def new
    @games = Games.find(params[:video_game_id])
    @booking = Booking.new
  end

  def create
    @games = Games.find(params[:video_game_id])
    @booking = Booking.new(booking_params)
    start_date = Date.parse(params[:booking][:start_date])
    end_date = Date.parse(params[:booking][:end_date])
    total_price = (end_date - start_date).to_i * @games.price
    @booking.total_price = total_price
    @booking.user = current_user
    @booking.games = @games
    if @booking.save
      render "confirmation"
    else
      render "new"
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
