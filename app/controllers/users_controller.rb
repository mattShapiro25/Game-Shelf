class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    #@friends = User.all #TODO REPLACE
    @friends = @user.friends # This will be fixed later  ----edit should be good
  end

  # def search
  #   if params[:query].present?
  #     @users = User.where('username LIKE ?', "%#{params[:query]}%")
  #   else
  #     @users = User.none 
  #   end
  # end


private

  def record_not_found
    flash[:alert] = "Invalid user."
    redirect_to home_index_path # temporary location
  end

end
