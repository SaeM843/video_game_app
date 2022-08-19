class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :approved, -> { where(status: true) }

  def total_price
    (end_date.day - start_date.day).to_i * offer.price
  end

  def pending?
    status == 'pending'
  end

  def color
    if status == "pending"
      "text-bg-info"
    elsif status == "rejected"
      "text-bg-danger"
    else
      "text-bg-success"
  end
end
end
