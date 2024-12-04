require 'rails_helper'

RSpec.describe "Ratings", type: :request do
  let(:game) { create(:game) }
  let(:user) { create(:user) }

  before do
    sign_in user  
  end

  describe "GET /new" do
    it "returns http success and renders the turbo frame" do
      get new_game_rating_path(game), headers: { 'Turbo-Frame' => 'new_rating' }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('<turbo-frame id="new_rating">')
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      it "redirects to the game show page" do
        post game_ratings_path(game), params: { rating: { stars: 5, text: "Great game!" } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(game_path(game))
      end
    end

    context "with invalid attributes (SAD)" do
      it "does not create a new rating, and renders the new template within the turbo frame" do
        post game_ratings_path(game), params: { rating: { stars: nil, text: "" } }, headers: { 'Turbo-Frame' => 'new_rating' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('class="new-rating-submit-button"') # Ensure the form is re-rendered
        expect(flash[:alert]).to eq("Rating could not be created")
      end
    end
  end

  describe "Cancel button" do
    it "loads the form with the cancel button and redirects correctly when canceled" do
      get new_game_rating_path(game), headers: { 'Turbo-Frame' => 'new_rating' }
      expect(response).to have_http_status(:success)

      expect(response.body).to include("Cancel")

      get game_path(game)
      expect(response).to have_http_status(:success)
  
      expect(response.body).to include(game.name) # Verify the game name is displayed
      expect(response.body).to include("Average Rating:") # Ensure show page elements are present
    end
  end
end
