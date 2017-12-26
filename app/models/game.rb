class Game < ApplicationRecord
  
  #belongs_to :clientUser, class_name: "Client"
  #belongs_to :Goalie, class_name: "Goalie", foreign_key: "id", optional: true
  
  belongs_to :client, class_name: "Client"
  belongs_to :Goalie, class_name: "Goalie", optional: true
  
end
