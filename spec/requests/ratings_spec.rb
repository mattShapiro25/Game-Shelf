require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:game) { create(:game) }
  let(:user) { create(:user) }

  before do
    sign_in user  # Assuming you are using Devise for authentication
  end

  describe "GET /new" do
    it "returns http success" do
      # Correct path for the 'new' action for reviews under a game
      get new_game_rating_path(game)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      # Correct path for the 'create' action for reviews under a game
      post game_ratings_path(game), params: { rating: { stars: 5, text: "Great game!" } }
      expect(response).to have_http_status(:redirect)  # assuming a redirect after successful creation
    end
  end
end