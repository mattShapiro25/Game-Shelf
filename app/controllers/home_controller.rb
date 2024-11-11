class HomeController < ApplicationController
    def index
        @games = Game.order(num_players: :desc).limit(8)
        @friends = User.all
        @user = current_user
    end
end
