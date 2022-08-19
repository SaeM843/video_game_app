class ReviewsController < ApplicationController
  def new
    @offer = Offer.find(params[:offer_id])
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @offer = Offer.find(params[:offer_id])
    @review.offer = @offer
    authorize @review
    if @review.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
