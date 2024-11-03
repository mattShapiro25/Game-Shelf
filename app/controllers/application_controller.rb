class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :check_sign_in_status
  
  protected

  # Redirect to the users index page after sign-in
  def after_sign_in_path_for(resource)
    authenticated_root_path # Adjust this path to match your desired index page
  end

  # Redirect to the sign-in page after sign-out
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # Redirect to the sign-in page after sign-up
  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def check_sign_in_status
    if user_signed_in?
      flash[:notice] = "You are currently signed in as #{current_user.email}."
    else
      flash[:alert] = "You are not signed in."
    end
  end


end
