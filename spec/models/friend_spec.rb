require 'rails_helper'

RSpec.describe Friend, type: :model do
	before(:each) do
    @user1 = User.create(email: "user1@example.com", password: "password")
    @user2 = User.create(email: "user2@example.com", password: "password")
  end


	describe "model attributes" do
    it "allows the creation of a Friend object with both user_id1 and user_id2" do
      friend = Friend.create(user_id1: 1, user_id2: 2)
      expect(friend).to be_valid
      expect(friend.user_id1).to eq(1)
      expect(friend.user_id2).to eq(2)
    end
  end

	describe ".create_bidirectional_friend" do
    it "creates two Friend records to represent a bidirectional friendship" do
      Friend.create_bidirectional_friend(@user1, @user2)

      expect(Friend.exists?(user_id1: @user1.id, user_id2: @user2.id)).to be true
      expect(Friend.exists?(user_id1: @user2.id, user_id2: @user1.id)).to be true
    end
  end

  describe "associations" do
    it "belongs to user1" do
      friend = Friend.create(user_id1: @user1.id, user_id2: @user2.id)
      expect(friend.user1).to eq(@user1)
    end

    it "belongs to user2" do
      friend = Friend.create(user_id1: @user1.id, user_id2: @user2.id)
      expect(friend.user2).to eq(@user2)
    end
  end

end