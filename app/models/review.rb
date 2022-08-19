class Review < ApplicationRecord
  belongs_to :offer
  has_many :reviews, dependent: :destroy
  validates :content, presence: true
end
