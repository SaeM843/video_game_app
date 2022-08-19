class OffersController < ApplicationController
  def index
    @offers = Offer.all

    # @markers = @offers.geocoded.map do |offer|
    #   {
    #     lat: offer.latitude,
    #     lng: offer.longitude
    #   }
    # end
    if params[:search].present?
      sql_query = <<~SQL
        video_games.title ILIKE :query
        OR video_games.category ILIKE :query
      SQL
      @offers = policy_scope(Offer.joins(:video_game).where(sql_query, query: "%#{params[:search][:query]}%"))

    else
      @offers = policy_scope(Offer)
    end
    # if params[:search][:query].present?
    #   @offers = policy_scope(VideoGame.search_by_title_and_genre(params[:search][:query]).offers)
    # else
    #   @offers = policy_scope(Offer)
    # end
  end

  def show
    @offer = Offer.find(params[:id])
    @offers = policy_scope(Offer)
    @booking = Booking.new
    # @marker = {
    #   lat: @offer.latitude,
    #   lng: @offer.longitude
    # }
    authorize @offer
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @video_game = VideoGame.find(params[:video_game_id])
    # @offer = policy_scope([:owner, Booking])
    @offer = Offer.new(offer_params)
    @offer.video_game = @video_game
    @offer.user = current_user
    authorize @offer
    if @offer.save
      redirect_to owner_bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:price, :video_game_id)
  end
end
