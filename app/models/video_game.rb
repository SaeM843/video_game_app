class VideoGame < ApplicationRecord
  has_many :offers
  has_many :bookings, through: :offers
  has_many :users, through: :offers
end
