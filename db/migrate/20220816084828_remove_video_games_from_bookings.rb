class RemoveVideoGamesFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference(:bookings, :video_game, foreign_key: true)
    add_reference(:bookings, :offer, null: false, foreign_key: true)
  end
end
