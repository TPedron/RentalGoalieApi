class ClientsController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :create, :show, :update, :destroy]
  
  def index
    @clients = Client.all  
    @clients.each do |curr|
      curr.averageRating = curr.games.where("clientRating IS NOT NULL").average('clientRating')
    end
    json_response(@clients)
  end
  
  def show
    @client = Client.find(params[:id])
    @client.averageRating = @client.games.where("clientRating IS NOT NULL").average('clientRating')
    json_response(@client)
  end
  
  def create
    @client = CLient.new(user_params)
    if @goalie.save
      log_in @client
      json_response(@client, :created)
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
      params.require(:client).permit(:name, :email)
    end
  
end
