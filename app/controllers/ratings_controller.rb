class RatingsController < ApplicationController
  before_action :set_game, only: [:new, :create]
  before_action :set_user, only: [:new, :create]
  
  # NEED TO IMPLEMENT HANDLE_BAD_ID FUNCTION
  # rescue_from ActiveRecord::RecordNotFound, with: :handle_bad_id 

  ##     WE SHOULD USE JAVASCRIPT TO HAVE NEW RATING FORM POP UP OVER SHOW PAGE ONCE WE LEARN IT
  ##     UNTIL THEN, WILL USE REDIRECT

  def new
    @rating = Rating.new
  end

  def create 
    @rating = @user.ratings.new(rating_params)
    @rating.game = @game
    
    if @rating.save
      # update rating 
      @game.num_ratings += 1
      @game.num_players += 1
      @game.avg_rating = (((@game.avg_rating * (@game.num_ratings - 1)) + @rating.stars) / @game.num_ratings).round(2)
      @game.save

      redirect_to game_path(@game), notice: "Rating created successfully"
    else
      flash[:alert] = 'Rating could not be created'
      render :new, status: :unprocessable_content
    end
  end

private 

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_user
    @user = current_user
  end

  def rating_params
    params.require(:rating).permit(:stars, :text)
  end
end