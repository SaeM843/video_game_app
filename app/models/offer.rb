class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :video_game
  validates :price, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
