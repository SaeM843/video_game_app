# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'rest-client'

puts "Cleaning up the database..."
VideoGame.destroy_all
puts "Database cleaned"

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
