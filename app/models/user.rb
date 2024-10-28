class User < ApplicationRecord
  has_secure_password # secure handling
  has_many :ratings
  has_many :rated_games, through: :ratings, source: :game

  # Friendships (self-referential relationship)
  has_many :friendships, foreign_key: :user_id1, class_name: "Friend"
  has_many :friends, through: :friendships, source: :user2
end
