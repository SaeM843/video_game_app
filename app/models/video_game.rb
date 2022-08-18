class VideoGame < ApplicationRecord
  has_many :offers
  has_many :bookings, through: :offers
  has_many :users, through: :offers
  # include PgSearch::Model
  # pg_search_scope :search_by_title_and_genre,
  # against: [ :title, :genre ],
  # using: {
  #   tsearch: { prefix: true }
  # }
end
