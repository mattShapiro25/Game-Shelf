class GamesController < ApplicationController
  def index
    @games = Game.all
    #@default_games = Game.top_ratings(16)
  end
  
  def show
    @game = Game.find(params[:id])

  end

  def index
    @games = Game.all.order(avg_rating: :desc)
    if params[:query].present? && params[:query].length > 2
      @games = @games.by_search_string(params[:query])
      @query_filt = params[:query]
    end
  end 


end
