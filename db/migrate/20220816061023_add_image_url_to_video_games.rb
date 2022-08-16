class AddImageUrlToVideoGames < ActiveRecord::Migration[7.0]
  def change
    add_column :video_games, :image_url, :string
  end
end
