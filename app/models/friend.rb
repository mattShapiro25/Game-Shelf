class Friend < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: :user_id1
  belongs_to :user2, class_name: "User", foreign_key: :user_id2

# Create friendship in both directions
  def self.create_bidirectional_friend(user1, user2)
    create!(user_id1: user1.id, user_id2: user2.id)
    create!(user_id1: user2.id, user_id2: user1.id)
  end

end
