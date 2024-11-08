# Run file to get Game data from the RAWG API

require 'net/http'
require 'json'
require 'fileutils'

API_KEY = ENV['RAWG_API_KEY']
BASE_URL = "https://api.rawg.io/api/games"

# Method to fetch API data
def fetch_games(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  else
    puts "Error: Unable to fetch data. HTTP Code: #{response.code}"
    puts uri
    nil
  end
end

# Collect game data into a hash
def collect_game_data(games_data)
  games_data.map do |game_data|
    {
      name: game_data['name'],
      description: game_data['description'] || 'No description provided',
      num_players: game_data.dig('added_by_status', 'playing').to_i + game_data.dig('added_by_status', 'toplay').to_i || 0,
      num_ratings: game_data['ratings_count'] || 0,
      avg_rating: game_data['rating'] || 0.0,
      image: game_data['background_image'] || 'default_image.png',
    }
  end
end

# Write game data (from API) to a JSON file
def write_to_json_file(data, iteration)
  FileUtils.mkdir_p('db')
  existing_data = []
  if File.exist?('db/seeds/games_data.json')
    existing_data = JSON.parse(File.read('db/seeds/games_data.json'))
  end
  existing_data.concat(data)

  # Write the data to the file
  File.open('db/seeds/games_data.json', 'w') do |file|
    file.write(JSON.pretty_generate(existing_data))
  end

  puts "Iteration #{iteration + 1} Complete"
end

url = "#{BASE_URL}?key=#{API_KEY}"
pages_to_fetch = 150
pages_fetched = 0

while url && pages_fetched < pages_to_fetch
  data = fetch_games(url)

  if data
    game_data = collect_game_data(data['results'])
    write_to_json_file(game_data, pages_fetched)
    url = data['next']
    pages_fetched += 1
  else
    break
  end
end

puts "Finished fetching and saving data"
