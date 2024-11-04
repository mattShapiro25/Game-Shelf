# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'json'

file_path = Rails.root.join('db', 'seeds', 'games.json')
data = JSON.parse(File.read(file_path))

games = data['results']  # Access the "results" array

games.each do |game_data|
  Game.create!(
    name: game_data['name'] || 'Unknown Name',
    description: game_data['description'] || 'No description provided',
    num_players: game_data.dig('added_by_status', 'playing').to_i + game_data.dig('added_by_status', 'toplay').to_i || 0,
    num_ratings: game_data['ratings_count'] || 0,
    avg_rating: game_data['rating'] || 0.0,
    image: game_data['background_image'] || 'default_image.png',
    created_at: game_data['created_at'] || Time.now,
    updated_at: game_data['updated_at'] || Time.now
  )
end