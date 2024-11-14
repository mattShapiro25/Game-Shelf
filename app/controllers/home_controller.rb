class HomeController < ApplicationController
    def index
        @games = Game.order(num_players: :desc).limit(8)
        @friends = current_user.friends
        @user = current_user
    end
end
