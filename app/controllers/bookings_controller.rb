class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @bookings = policy_scope(Booking)
  end

  def show
    authorize @booking
  end

  def new
    @offers = Offers.find(params[:video_game_id])
    @booking = Booking.new
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      # redirect_to # up to you...
    else
      # render # where was the booking update form?
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end

  def create
    @offers = Offers.find(params[:video_game_id])
    @booking = Booking.new(booking_params)
    @booking.total_price = total_price
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

def index
  if params[:query].present?
    @booking = Booking.where("title ILIKE ?", "%#{params[:query]}%")
  else
    @booking = Booking.all
  end
end

def base
  if params[:query].present?
    sql_query = "title ILIKE :query OR overwiev ILIKE :query"
    @booking = Booking.where(sql_query, query: "%#{params[:query]}%")
  else
    @booking = Booking.all
  end
end
