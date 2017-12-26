class GamesController < ApplicationController
  
  include SessionsHelper
  
  before_action :set_game, only: [:show, :update, :destroy, :accept, :unaccept, :rate]
  before_action :logged_in_user, only: [:index, :create, :show, :update, :destroy, :accept, :unaccept, :rate]
  before_action :isUser, only: [:create, :destroy, :show, :update]
  before_action :isGoalie, only: [:accept, :unaccept]

  # GET /games
  # GET /games.json
  def index
    if params[:view] == "all"
      @games = Game.all
    elsif params[:view] == "active"
      @games = Game.where("date >= ?", Time.zone.now)
    elsif params[:view] == "available"
      @games = Game.where(goalie_id: nil).where("date >= ?", Time.zone.now)
    elsif params[:view] == "taken"
      @games = Game.where("goalie_id > 0").where("date >= ?", Time.zone.now)
    end
    json_response(@games, :ok)
  end

  # GET /games/1
  # GET /games/1.json
  def shows
    @game = Game.find(params[:id])
    json_response(@game, :ok)
  end

  # POST /games
  # POST /games.json
  def create
    puts @current_user.name
    #puts @current_user.gamesCreated.length
    @game = @current_user.games.build(game_params)
    if @game.save!
      json_response(@game, :ok)
    else
      json_response(nil, :bad_request)
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      #render :show, status: :ok, location: @game
      json_response(@game, :ok)
    else
      #render json: @game.errors, status: :unprocessable_entity
      json_response(@game, :ok)
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    json_response(nil, :no_content)
  end
  
  def accept
    puts "goalie = " + @current_user.id.to_s
    puts "game = " + @game.id.to_s
    @current_user.games.push(@game)
    if @game.save! && @current_user.save!
      json_response(@game, :ok)
    else
      json_response(nil, :bad_request)
    end
  end
  
  def unaccept
    puts "goalie = " + @current_user.id.to_s
    puts "game = " + @game.id.to_s
    @current_user.games.delete(@game)
    if @game.save! && @current_user.save!
      @game.reload
      json_response(@game, :ok)
    else
      json_response(nil, :bad_request)
    end
  end
  
  def rate
    puts "current user "+@current_user.id.to_s+ " is "+@current_user.type
    if @current_user.type == "Client"
      @game.goalieRating = params[:rating]
    elsif @current_user.type == "Goalie"
      @game.clientRating = params[:rating]
    end
    if @game.save!
      @game.reload
      json_response(@game, :ok)
    else
      json_response(nil, :bad_request)
    end
    
      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      puts params
      params.require(:game).permit(:arena, :date)
    end
  
end