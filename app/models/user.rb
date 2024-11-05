class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ratings
  has_many :rated_games, through: :ratings, source: :game

  # Friendships (self-referential relationship)
  has_many :friendships, foreign_key: :user_id1, class_name: "Friend"
  has_many :friends, through: :friendships, source: :user2


  # validations; not needed now
  # validates :ratings, presence: true
  # validates :rated_games, presence: true
  # validates :friendships, presence: true
  # validates :friends, presence: true
end
