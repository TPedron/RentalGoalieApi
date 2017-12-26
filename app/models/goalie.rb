class Goalie < User
  #has_many :gamesPlayed, class_name: "Game", foreign_key: "id"
  #has_many :games, through: :gamesPlayed, source: :games
  
  has_many :games, class_name: "Game", source: :games
  
end
