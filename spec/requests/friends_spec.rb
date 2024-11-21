require 'rails_helper'

RSpec.describe "Friends", type: :request do
  before(:each) do
    @user = User.create!(email: "user@example.com", password: "password", username: "user1")
    @friend = User.create!(email: "friend@example.com", password: "password", username: "friend1")
    @other_user = User.create!(email: "other@example.com", password: "password", username: "otheruser")
    sign_in @user
  end

  #Tests for INDEX
  describe "GET /users/:user_id/friends (INDEX)" do
    it "lists the user's friends" do
      Friend.create_bidirectional_friend(@user, @friend) 
      get user_friends_path(@user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@friend.username)
    end
  end

#Tests for SHOW
  describe "GET /users/:user_id/friends/:id (SHOW)" do
    it "shows the friend's details" do
      Friend.create_bidirectional_friend(@user, @friend)  # Add friend
      get user_friend_path(@user, @friend)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@friend.username)  # Assuming the username is displayed on the show page
    end

    it "redirects to home page with flash alert when friend is not found" do
      get user_friend_path(@user, id: -1)

      expect(response).to redirect_to(home_index_path)
      follow_redirect!
      expect(response.body).to include("Invalid user.")
    end
  end

#Tests for NEW
  describe "GET /users/:user_id/friends/new (NEW)" do
    it "renders the new friend form" do
      get new_user_friend_path(@user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Would you like to add a friend?") 
    end
  end

#Tests for CREATE
  describe "POST /users/:user_id/friends (CREATE)" do
    context "when adding a valid friend" do
      it "adds the friend and redirects" do
        post user_friends_path(@user), params: { friend_id: @friend.id }
        expect(response).to redirect_to(user_friends_path(@user))
        follow_redirect!
        expect(response.body).to include("Friend added successfully!")
      end
    end

    context "when trying to add yourself as a friend" do
      it "shows an alert and does not add the friend" do
        post user_friends_path(@user), params: { friend_id: @user.id }
        expect(response).to redirect_to(user_friends_path(@user))
        follow_redirect!
        expect(response.body).to include("You cannot add yourself as a friend.")
      end
    end

    context "when already friends" do
      it "shows an alert and does not add the friend" do
        Friend.create_bidirectional_friend(@user, @friend)
        post user_friends_path(@user), params: { friend_id: @friend.id }
        expect(response).to redirect_to(user_friends_path(@user))
        follow_redirect!
        expect(response.body).to include("You are already friends with this user.")
      end
    end
  end

#Tests for Search
  describe "GET /users/:user_id/friends/search (SEARCH)" do
    context "when query is present" do
      it "returns matching users" do
        get search_user_friends_path(@user), params: { query: "friend1" }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(@friend.username)
      end
    end

    context "when query is not present" do
      it "returns no users" do
        get search_user_friends_path(@user), params: { query: "nonexistent" }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("No users found")
      end
    end

    it "returns no results when the search query does not match any users" do
      get search_user_friends_path(@user), params: { query: "nonexistentuser" }
      expect(response).to be_successful
      expect(assigns(:users)).to be_empty
    end

    context "when no query is provided" do
      it "assigns an empty collection to @users" do
        get search_user_friends_path(@user) 
        expect(response).to have_http_status(:ok)
        expect(assigns(:users)).to eq(User.none)
      end
    end
  end


end
