class Client < User
  
  #has_many :gamesCreated, class_name: "Game", foreign_key: "clientUser_id"
  #has_many :games, through: :gamesCreated, source: :games
  
  has_many :games, class_name: "Game", source: :games
  
end
