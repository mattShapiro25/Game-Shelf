class HomeController < ApplicationController
    def index
        @games = Game.order(num_players: :desc).limit(10)
    end
end
