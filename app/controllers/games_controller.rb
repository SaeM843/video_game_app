# def convert_date_to_number(date)
#   return (date - Date.new(2022, 08, 16)).to_i
# end

# def convert_number_to_date(number)
#   return (Date.new(2022, 08, 16) + number.days)
# end

class GamesController < ApplicationController
#   before_action :set_games, only: %i[show destroy]

#   def index
#     @games = Games.all

#     if params[:search][:city].present?
#       @games = @games.near(params[:search][:city], 5)
#     end

#     if params[:search][:brand].present?
#       @games = @games.where(brand: params[:search][:brand])
#     end

#     if params[:search][:start_date].present?
#       userStart = convert_date_to_number(Date.parse(params[:search][:start_date]))
#       userEnd = convert_date_to_number(Date.parse(params[:search][:end_date]))

#       availability = Hash.new
#       Games.all.each do |game|
#         availability[game[:id]] = Array.new(userEnd - userStart + 1, 1)
#       end

#       Booking.all.each do |booking|
#         bookingStart = convert_date_to_number(booking[:start_date])
#         bookingEnd = convert_date_to_number(booking[:end_date])
#         if bookingEnd >= userStart && bookingStart <= userEnd
#           indexStart = bookingStart < userStart ? 0 : bookingStart - userStart
#           indexEnd = bookingEnd > userEnd ? userEnd - userStart : bookingEnd - userStart
#           (indexStart..indexEnd).each do |i|
#             availability[booking[:video_game_id]][i] = 0
#           end
#         end
#       end

#       @games = @games.select do |game|
#         !availability[game[:id]].include? 0
#       end
#     end
#   end

#   def show
#   end

#   def new
#     @games = Games.new
#   end

#   def create
#     @games = Games.new(game_params)
#     @games.user = current_user
#     if @games.save
#       redirect_to games_path(@games), alert: 'Your game was successfully created!'
#     else
#       render :new
#     end
#   end

#   def destroy
#     @games.destroy

#     redirect_to bookings_path
#   end

#   private

#   def games_params
#     params.require(:games).permit(:title, :description, :photo, :price, :type)
#   end

#   def set_games
#     @games = Games.find(params[:id])
#   end
end
