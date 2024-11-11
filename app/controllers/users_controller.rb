class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    @friends = User.all #TODO REPLACE
    # @friends = @user.friends # This will be fixed later
  end

  def record_not_found
    flash[:alert] = "Invalid user."
    redirect_to authenticated_root_path # temporary location
  end
end
