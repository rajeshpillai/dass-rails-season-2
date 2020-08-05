class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u|      
      u.permit(:username, :email, :password)}
  end
end
