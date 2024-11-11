FactoryBot.define do
  factory :user do
    email { "testuser@example.com" }
    username { "TestUser" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end