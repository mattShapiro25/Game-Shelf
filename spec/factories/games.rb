FactoryBot.define do
  factory :game do
    name { "Sample Game" }
    description { "This is a description of a sample game." }
    avg_rating { 4.5 }
    image { "https://example.com/sample-image.jpg" }  # Example image URL, you can replace this with a valid image path
    num_ratings { 100 }
    num_players { 1 }
  end
end