class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :stars, presence: true, inclusion: { in: 1..5 }
end
