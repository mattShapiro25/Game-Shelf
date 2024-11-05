class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    
  end

  def show

  end

  def new

  end

  def create

  end

  def destroy

  end

  def edit

  end

  def update

  end

  def record_not_found
    flash[:alert] = "Invalid user."
    redirect_to authenticated_root_path # temporary location
  end
end
