require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  before(:each) do
    @user = User.create!(email: "user@example.com", password: "password", username: "user1")
    @other_user = User.create!(email: "other@example.com", password: "password", username: "user2")
    Friend.create_bidirectional_friend(@user, @other_user)
  end

  describe "GET /users/:id (INDEX)" do
    context "when the user exists" do
      it "returns the user page with the correct information" do
        sign_in @user
        get user_path(@user)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(@user.username) 
      end
    end

    context "when the user does not exist" do
      it "redirects to the home page with a flash message" do
        sign_in @user
        get user_path(-1) 
        expect(response).to redirect_to(home_index_path)
        expect(flash[:alert]).to eq("Invalid user.")
      end
    end
  end

  describe "GET /users/:id/friends (SHOW)" do
    context "when the user exists" do
      it "returns the friends page for the user" do
        sign_in @user
        get user_friends_path(@user)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Friends")
      end
    end
          #### THIS TEST DOES NOT WORK - not sure why
    context "when the user does not exist" do
      it "redirects to the home page with a flash message" do
        sign_in @user
        get user_friends_path(-1) 
        expect(response).to redirect_to(home_index_path) 
        expect(flash[:alert]).to eq("Invalid user.")    
      end
    end    
  end

  describe "Devise access control" do
    context "when not signed in" do
      it "redirects to the login page for /users/:id" do
        get user_path(@user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "redirects to the login page for /users/:id/friends" do
        get user_friends_path(@user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
