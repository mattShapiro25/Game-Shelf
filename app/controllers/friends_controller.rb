class FriendsController < ApplicationController
	before_action :authenticate_user! 
  before_action :set_user

	rescue_from ActiveRecord::RecordNotFound, with: :handle_bad_user_id

	def index 
		@friends = @user.friends
	end

	#	NOT
	# def show 
	# 	@friend = @user.friends.find(params[:id])
	# end

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

		Friend.create_bidirectional_friend(@user, @friend)

    flash[:notice] = "Friend added successfully!"
		redirect_to request.referer || user_friends_path(current_user)
	end

	def destroy
		@friend = @user.friends.find(params[:id])
		Friend.destroy_bidirectional_friend(current_user, @friend)
		flash[:notice] = "Friend removed successfully"
		redirect_to request.referer || user_friends_path(current_user)
	end

	def search
    if params[:query].present?
			friend_ids = Friend.where('user_id1 = ? OR user_id2 = ?', current_user.id, current_user.id).pluck(:user_id1, :user_id2).flatten.uniq.reject { |id| id == current_user.id }

			# remove current friends from results
			@users = User.where('username LIKE ?', "%#{params[:query]}%").where.not(id: friend_ids)
    else
      @users = User.none
    end
	end

private 
  
	def set_user
  		@user = current_user
		redirect_to new_user_session_path unless @user
	end

	#	Not needed
	# def handle_bad_user_id
    # 	flash[:alert] = 'Invalid user.'
    # 	redirect_to home_index_path
	# end
end
