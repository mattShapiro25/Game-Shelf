require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:user) { create(:user) }

  before do
    @game1 = Game.create!(name: "Chess")
    @game2 = Game.create!(name: "Checkers")
    sign_in user
  end
  
  describe "GET /index" do
    it "assigns all games to @games" do
      get :index
      expect(assigns(:games)).to match_array([@game1, @game2])
    end
  end
end


