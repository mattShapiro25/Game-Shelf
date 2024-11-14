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
	 @friend = Friend.new
	end

	def create
		@user = User.find(params[:user_id])
		@friend = User.find(params[:friend_id])

		if @friend == current_user
      flash[:alert] = "You cannot add yourself as a friend."
      redirect_to user_friends_path(current_user) and return
    end

    if current_user.friends.include?(@friend)
      flash[:alert] = "You are already friends with this user."
      redirect_to user_friends_path(current_user) and return
    end

		Friend.create_bidirectional(@user, @friend)

    flash[:notice] = "Friend added successfully!"
    redirect_to user_friends_path(current_user)

	end

	def search
    if params[:query].present?
      @users = User.where('username LIKE ?', "%#{params[:query]}%")
    else
      @users = User.none
    end
	end

private 
  
  def set_user
  	@user = current_user
		redirect_to new_user_session_path unless @user
	end
  
end
