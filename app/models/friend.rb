class Friend < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: :user_id1
  belongs_to :user2, class_name: "User", foreign_key: :user_id2

# Create friendship in both directions
  def self.create_bidirectional_friend(user1, user2)
    create!(user_id1: user1.id, user_id2: user2.id)
    create!(user_id1: user2.id, user_id2: user1.id)
  end

  def self.destroy_bidirectional_friend(user1, user2)
    user1.friends.delete(user2)
    user2.friends.delete(user1)
  end
  
  #ensures only unique friendships can be created
  validates :user_id1, uniqueness: { scope: :user_id2 }


end
