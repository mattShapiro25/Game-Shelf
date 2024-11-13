require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:game) { create(:game) }
  let(:user) { create(:user) }

  before do
    sign_in user  
  end

  describe "GET /new" do
    it "returns http success" do
      get new_game_rating_path(game)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post game_ratings_path(game), params: { rating: { stars: 5, text: "Great game!" } }
      expect(response).to have_http_status(:redirect) 
    end
  end

  describe "POST /create" do
    context "with invalid attributes (SAD)" do
      it "does not create a new rating and renders the new template with an error" do
        post game_ratings_path(game), params: { rating: { stars: nil, text: "" } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_content)
        expect(flash[:alert]).to eq("Rating could not be created")
      end
    end
  end 

end

