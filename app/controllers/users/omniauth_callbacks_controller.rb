class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      redirect_to edit_user_registration_path(@user) and return 
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url and return
    end
  end

  def failure
    redirect_to root_path
  end
end
