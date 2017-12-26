class AddRatingsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :clientRating, :integer
    add_column :games, :goalieRating, :integer
  end
end
