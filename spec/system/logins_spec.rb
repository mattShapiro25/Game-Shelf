require 'rails_helper'

RSpec.describe "Logins", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user, email: 'user@example.com', password: 'password123') }
  
  it "log in successfully with correct credentials" do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
      expect(page).to have_content("Signed in successfully")
      expect(page).to have_current_path(home_index_path) 
  end
  
  describe "sad paths for login" do
    it "fails to log in when user does not exist" do
      visit new_user_session_path
      fill_in 'Email', with: 'FAKEEMAIL@example.com'
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      expect(page).to have_current_path(new_user_session_path)
    end

    it "fails to log in when password is incorrect" do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'FAKEPASSWORD'
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      expect(page).to have_current_path(new_user_session_path)
    end

    it "fails to log in when email is empty" do
      visit new_user_session_path
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password123'
      click_button 'Log in'

      expect(page).to have_content("Invalid Email or password.")
      expect(page).to have_current_path(new_user_session_path)
    end

    it "fails to log in when password is empty" do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content("Invalid Email or password.")
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
