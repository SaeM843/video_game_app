class BookingsController < ApplicationController
  def index
    @booking = Booking.where(user_id: current_user)
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
      redirect_to bookings_path
    else
      render offer_path(@offer), status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

# def index
#   if params[:query].present?
#     @booking = Booking.where("title ILIKE ?", "%#{params[:query]}%")
#   else
#     @booking = Booking.all
#   end
# end

# def base
#   if params[:query].present?
#     sql_query = "title ILIKE :query OR overwiev ILIKE :query"
#     @booking = Booking.where(sql_query, query: "%#{params[:query]}%")
#   else
#     @booking = Booking.all
#   end
# end
