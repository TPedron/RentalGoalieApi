class GoaliesController < ApplicationController
  
  def show
    @goalie = Goalie.find(params[:id])
    json_response(@goalie)
  end
  
  def index
    @goalies = Goalie.all  
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