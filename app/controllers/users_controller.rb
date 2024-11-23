class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @games_with_ratings = Rating.joins(:game).where(user_id: @user.id).select("games.*, ratings.stars AS user_rating")
    @friends = @user.friends
    @games_played_count = @user.ratings.count
  end

private

  def record_not_found
    flash[:alert] = "Invalid user."
    redirect_to home_index_path 
  end


end
