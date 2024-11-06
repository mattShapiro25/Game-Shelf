# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'json'

file_path = Rails.root.join('db', 'seeds', 'games_data.json')
games = JSON.parse(File.read(file_path))

games.each do |game|
  Game.create!(
    name: game['name'],
    description: game['description'],
    num_players: game['num_players'],
    num_ratings: game['num_ratings'],
    avg_rating: game['avg_rating'],
    image: game['image'],
    created_at: Time.now,
    updated_at: Time.now
  )
end

# Seed sample User
User.create!(
  username: 'testuser',
  email: 'testuser@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  number_of_ratings: 0
)
