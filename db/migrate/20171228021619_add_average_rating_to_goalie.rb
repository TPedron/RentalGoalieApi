class AddAverageRatingToGoalie < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :averageRating, :integer
  end
end
