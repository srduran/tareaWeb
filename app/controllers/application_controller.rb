class ApplicationController < ActionController::Base
  puts("holaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :documents_path
  before_action :authenticate_person!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email])
  end
  protect_from_forgery with: :exception
end