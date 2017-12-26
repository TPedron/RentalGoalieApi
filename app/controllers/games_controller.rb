class GamesController < ApplicationController
  
  include SessionsHelper
  
  before_action :set_game, only: [:show, :update, :destroy]
  before_action :logged_in_user, only: [:create, :show, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
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