class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :current_admin_user
  def after_sign_in_path_for(resource)

  if resource.is_a?(User) && resource.provider == "github"
    edit_user_registration_path(resource)
  else
    super
  end
end
end
