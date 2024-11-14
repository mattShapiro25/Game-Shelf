class FriendsController < ApplicationController
	before_action :authenticate_user! 
  before_action :set_user

	def index 
		@friends = @user.friends
	end

	def show 
		@friend = @user.friends.find(params[:id])
	end

	def new
	
	end

	def create
	
	end

private 
  
  def set_user
  	@user = current_user
		redirect_to new_user_session_path unless @user
	end
  
end
