class OffersController < ApplicationController
  def index
    @offers = Offer.all
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude
      }
    end
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
    @marker = {
      lat: @offer.latitude,
      lng: @offer.longitude
    }
    authorize @offer
  end

  def new
    @offer = Offer.new
    @video_game = VideoGame.find(params[:video_game_id])
    authorize @offer
  end

  def create
    @video_game = VideoGame.find(params[:video_game_id])
    @offer = Offer.new(offer_params)
    authorize @offer
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:price)
  end
end
