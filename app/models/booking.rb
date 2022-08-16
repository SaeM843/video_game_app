class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  belongs_to :video_game

  def total_price
    (end_date - start_date).to_i * offer.price
  end
end
