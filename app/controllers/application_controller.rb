class ApplicationController < ActionController::Base

  
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :position])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :position])
  end
end