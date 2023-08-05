class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :current_admin_user
end
