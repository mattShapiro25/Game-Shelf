require 'rails_helper'

RSpec.describe "Logins", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "happy path for login" do
    pending "logs in successfully"
  end
  
  describe "sad paths for login" do
    pending "user does not exist"
    pending "password is incorrect"
    pending "email is empty"
    pending "password is empty"
  end
end
