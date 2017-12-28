class GoaliesController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :create, :show, :update, :destroy]
  
  def show
    @goalie = Goalie.find(params[:id])
    @goalie.averageRating = @goalie.games.where("goalieRating IS NOT NULL").average('goalieRating')
    json_response(@goalie)
  end
  
  def index
    @goalies = Goalie.all  
    @goalies.each do |curr|
      curr.averageRating = curr.games.where("goalieRating IS NOT NULL").average('goalieRating')
    end
    json_response(@goalies)
  end
  
  def create
    @goalie = Goalie.new(user_params)
    if @goalie.save
      log_in @goalie
      json_response(@goalie, :created)
    else
      json_response(nil, :bad_request)
    end
  end
  
  def games
    @current_user = current_user
    json_response(@current_user.games, :ok)
  end
  
  private
    def user_params
      puts params
      params.require(:goalie).permit(:name, :email)
    end
    
  
end
