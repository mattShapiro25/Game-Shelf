class Game < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates :name, presence: true

  def top_ratings(limit = 5)
    ratings.order(stars: :desc).limit(limit)
  end

end
