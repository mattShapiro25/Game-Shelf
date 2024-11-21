class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.all.order(avg_rating: :desc).limit(20)
    @popular = Game.all.order(num_players: :desc).limit(20)

    @top = Game.all.order(avg_rating: :desc).limit(8)
    @top_more = Game.all.order(avg_rating: :desc).limit(20)

    # Find games rated by friends
    @friend_ids = current_user.friends.pluck(:id)
    @games_friends_played = Game.joins(:ratings).where(ratings: { user_id: @friend_ids }).distinct

    if params[:query].present? && params[:query].length > 2
      @games = @games.by_search_string(params[:query])
      @query_filt = params[:query]
    end

  end 


end
