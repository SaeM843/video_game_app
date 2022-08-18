class Booking < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  belongs_to :offer

  scope :approved, -> { where(status: true) }

  def total_price
    (end_date - start_date).to_i * offer.price
  end


end
