# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'

puts "Cleaning up the video game database..."
VideoGame.destroy_all
puts "Video game database cleaned"

puts "Getting video games data"

def games_dataset
  games = RestClient.get("https://api.rawg.io/api/games?key=#{ENV["RAWG_API_KEY"]}")
  games_array = JSON.parse(games)["results"]
  games_array.each do |video_game|
    VideoGame.create(
      title: video_game["name"],
      overview: Faker::Lorem.paragraphs,
      publishing_year: video_game["released"],
      category: video_game["genres"][0]["name"],
      image_url: video_game["background_image"]
    )
  end
end

games_dataset
puts "Seeding video games data"
puts "Created #{VideoGame.count} video games"

################################################

puts "Cleaning up the user database"
User.destroy_all
puts "User database cleaned"

puts "Getting user data"

User.create!(email: "alison@videogames.com", password: "123123", name: "Alison")
User.create!(email: "alex@videogames.com", password: "123123", name: "Alex")
User.create!(email: "koki@videogames.com", password: "123123", name: "Koki")
User.create!(email: "sae@videogames.com", password: "123123", name: "Sae")

puts "Created #{User.count} users"

################################################

puts "Cleaning up the offers and bookings database"
Offer.destroy_all
Booking.destroy_all
puts "Offers and bookings database cleaned"

puts "Getting offers and bookings data"

10.times do
  User.all.each do |user|
    user.video_games << VideoGame.all.sample
  end
end

puts "Created #{User.first.video_games.count} video games for #{User.first.email}"

# puts "Creating offers and bookings"

# User.all.each do |user|
#   user.video_games.each do |video_game|
#     Offer.create!(user:, video_game:)
#     Booking.create!(user:, offer: Offer.find_by(user:, video_game:))
#   end
# end

# puts "Created #{Offer.count} offers and #{Booking.count} bookings"
