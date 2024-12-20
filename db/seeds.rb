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

# Load users
users_file = File.read(Rails.root.join('db', 'seeds', 'users.json'))
users_data = JSON.parse(users_file)

# Create users
users_data.each do |user_data|
  User.create!(
    username: user_data['username'],
    email: user_data['email'],
    password: user_data['password'],
    password_confirmation: user_data['password'],
    number_of_ratings: user_data['number_of_ratings']
  )
end

# Load ratings
ratings_file = File.read(Rails.root.join('db', 'seeds', 'ratings.json'))
ratings_data = JSON.parse(ratings_file)

# Create ratings
ratings_data.each do |rating_data|
  Rating.create!(
    user_id: rating_data['user_id'],
    game_id: rating_data['game_id'],
    stars: rating_data['stars'],
    text: rating_data['text']
  )
end

friends_file = File.read(Rails.root.join('db', 'seeds', 'friends.json'))
friends_data = JSON.parse(friends_file)
friends_data.each do |friendship|
  Friend.create!(
    user_id1: friendship['user_id1'],
    user_id2: friendship['user_id2']
  )
end

puts("Database seeded sucessfully")