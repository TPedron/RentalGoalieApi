class ChangeColumn < ActiveRecord::Migration[5.1]
  def change
    
    change_column :games, :goalie_id, :integer, :default => -1
    
  end
end
