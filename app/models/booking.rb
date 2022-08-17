class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  def total_price
    (end_date - start_date).to_i * offer.price
  end
end
