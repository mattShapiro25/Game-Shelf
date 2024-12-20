require 'rails_helper'

RSpec.describe "Newusers", type: :system do
  before do
    driven_by(:rack_test)
    @testUser = User.create!(email: "user@example.com", password: "password", username: "user1")

  end

  describe "happy path for new account creation" do
    it "creates a new account" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # currently only distinguishable text on page
      signup_via_form("test@colgate.edu", "username", "password123", "password123")
      expect(page).to have_content('Welcome')  # if signed in
    end
  end

  describe "sad paths for new account creation" do
    it "does not correctly confirm password" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "username", "password123", "password456")
      expect(page).to have_content("Password confirmation doesn't match Password")  # error message
    end

    it "password is invalid" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "username", "123", "123")
      expect(page).to have_content('Password is too short (minimum is 6 characters)') # error message
    end

    it "password is empty" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "username", "", "")
      expect(page).to have_content("Password can't be blank") # error message
    end

    it "email is empty" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("", "username", "password123", "password123")
      expect(page).to have_content("Email can't be blank") # error message
    end

    # nah
    # it "username is empty" do
    #   visit "/" # home page
    #   click_on 'Sign up'
    #   expect(page).to have_content('Password (6 characters minimum)') # unique to this page
    #   signup_via_form("test@colgate.edu", "", "password123", "password123")
    #   expect(page).to have_content("Username can't be blank") # error message
    # end

    it "user email is already taken" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("user@example.com", "username", "password123", "password123")
      expect(page).to have_content("Email has already been taken") # error message
    end
  end

  def signup_via_form(email, username, password, confirm_password)
    fill_in "Email", with: email
    fill_in "Username", with: username
    fill_in "Password", with: password
    fill_in 'Password confirmation', with: confirm_password
    click_button "Sign up"
  end
end
