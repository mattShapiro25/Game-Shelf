class Game < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates :name, presence: true

  def top_ratings(limit)
    ratings.order(stars: :desc).limit(limit)
  end

  def self.by_search_string(search)
    Game.where("description LIKE ?", "%#{search}%").or(Game.where("name LIKE ?", "%#{search}%")).order(:name)
  end

end
