class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
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

  def edit
    raise
    # authorize @offer
  end

  def update
    raise
    # authorize @offer
  end

  def destroy
    raise
    # authorize @offer
  end

  private

  def offer_params
    params.require(:offer).permit(:price)
  end
end
