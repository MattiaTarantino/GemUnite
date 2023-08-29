class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :current_admin_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password, field_ids: [])}
  end
end
