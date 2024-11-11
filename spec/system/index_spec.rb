require 'rails_helper'

RSpec.describe 'Home Page', type: :feature do
  let!(:user) { create(:user, email: "testuser@example.com", username: "TestUser") }
  let!(:game1) { create(:game, name: "Game 1", avg_rating: 4.8, image: "game1.jpg") }
  let!(:game2) { create(:game, name: "Game 2", avg_rating: 4.6, image: "game2.jpg") }
  let!(:friend1) { create(:user, email: "friend1@example.com", username: "Friend1", number_of_ratings: 10) }
  let!(:friend2) { create(:user, email: "friend2@example.com", username: "Friend2", number_of_ratings: 20) }

  before do
    sign_in user
    visit "/"
  end

  it 'displays the current user email correctly' do
    expect(page).to have_content("Welcome testuser")
  end

  it 'displays popular games with their details' do
    expect(page).to have_content("Popular Games")
    expect(page).to have_content(game1.name)
    expect(page).to have_content(game1.avg_rating)
    expect(page).to have_selector("img[src='game1.jpg']")
  end

  it 'links to the individual game page' do
    click_link game1.name
    expect(current_path).to eq(game_path(game1))
  end

  it 'displays friends with their profile picture and info' do
    expect(page).to have_content("Friends")
    expect(page).to have_content(friend1.username)
    expect(page).to have_content(friend1.number_of_ratings)
    expect(page).to have_selector("div.profile-circle", text: friend1.email[0].upcase)
  end
  
  it 'has a link to see all friends' do
    expect(page).to have_link("See all", href: friends_path(user))
  end
end
