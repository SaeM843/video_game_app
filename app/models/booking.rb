class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates :start_date, presence: true
  validates :end_date, presence: true

  def total_price
    (end_date - start_date).to_i * offer.price
  end
end
