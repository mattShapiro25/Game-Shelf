class ApplicationController < ActionController::Base 
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    home_index_path  # Replace with the path helper for home#index
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username]) 
  end
end
