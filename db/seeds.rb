# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'

puts "Cleaning up the offers database..."
Offer.destroy_all
puts "Offer database cleaned"

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
User.create!(email: "abc@videogames.com", password: "123123", name: "Abc")
User.create!(email: "def@videogames.com", password: "123123", name: "Def")
User.create!(email: "ghi@videogames.com", password: "123123", name: "Ghi")
User.create!(email: "jkl@videogames.com", password: "123123", name: "Jkl")
User.create!(email: "mno@videogames.com", password: "123123", name: "Mno")
User.create!(email: "pqr@videogames.com", password: "123123", name: "Pqr")
User.create!(email: "stu@videogames.com", password: "123123", name: "Stu")
User.create!(email: "vwx@videogames.com", password: "123123", name: "Vwx")
User.create!(email: "yz@videogames.com", password: "123123", name: "Yz")

puts "Created #{User.count} users"

################################################

puts "Cleaning up bookings database"
Booking.destroy_all
puts "Bookings database cleaned"

puts "Getting offers and bookings data"

10.times do
  User.all.each do |user|
    user.video_games << VideoGame.all.sample
  end
end

puts "Created #{User.first.video_games.count} video games for #{User.first.email}"

puts "Creating offers and bookings"

prices = [150, 220, 270, 310, 340, 500, 550, 580, 600, 640]

User.all.each do |user|
  offer = Offer.create!(user: user, video_game: VideoGame.all.sample, price: prices.sample)
  Booking.create!(user: User.where.not(id: user).sample, offer: offer, start_date: Date.today + rand(1..3), end_date: Date.today + rand(7..12))
end

puts "Created #{Offer.count} offers and #{Booking.count} bookings"
