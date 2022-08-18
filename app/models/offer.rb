class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :video_game
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
