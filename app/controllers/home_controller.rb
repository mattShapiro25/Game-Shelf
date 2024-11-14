class HomeController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user

    def index
        @games = Game.order(num_players: :desc).limit(8)
        @friends = current_user.friends
        @user = current_user
    end

private

  def set_user
    @user = current_user
    redirect_to new_user_session_path unless @user
  end

end
