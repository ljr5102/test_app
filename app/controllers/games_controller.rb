class GamesController < ApplicationController
  def create
    @game = Game.create!
    render json: @game.slice(game_params)
  end

  def show
    @game = Game.find_by(id: params[:id])
    if @game
      render json: @game.slice(game_params)
    else
      render json: { Error: "Invalid id" }
    end
  end

  def move
    @game = Game.find_by(id: params[:id])
    mover = GameMover.new(game: @game, subgame: params[:subgame], cell: params[:cell]).execute!

    if mover.error
      render json: { Error: mover.error }
    else
      render json: @game.slice(game_params)
    end
  end

  private

  def game_params
    [:id, :board, :winner, :turn, :valid_subgames]
  end
end
