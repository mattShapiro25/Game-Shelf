require 'rails_helper'

RSpec.describe "Newusers", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "happy path for new account creation" do
    it "creates a new account" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # currently only distinguishable text on page
      signup_via_form("test@colgate.edu", "password123", "password123")
      expect(page).to have_content('You are currently signed in as')  # if signed in
    end
  end

  describe "sad paths for new account creation" do
    it "does not correctly confirm password" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "password123", "password456")
      expect(page).to have_content("Password confirmation doesn't match Password")  # error message
    end

    it "password is invalid" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "123", "123")
      expect(page).to have_content('Password is too short (minimum is 6 characters)') # error message
    end

    it "password is empty" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("test@colgate.edu", "", "")
      expect(page).to have_content("Password can't be blank") # error message
    end

    it "email is empty" do
      visit "/" # home page
      click_on 'Sign up'
      expect(page).to have_content('Password (6 characters minimum)') # unique to this page
      signup_via_form("", "password123", "password123")
      expect(page).to have_content("Email can't be blank") # error message
    end

    pending "user email is already taken"
  end

  def signup_via_form(email, password, confirm_password)
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in 'Password confirmation', with: confirm_password
    click_button "Sign up"
  end
end
