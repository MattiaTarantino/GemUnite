# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |user|
      Rails.logger.info("PARAMS: #{params.inspect}")
      if params[:field_ids].present?
        selected_field_ids = params[:field_ids].reject(&:blank?)
  
        if selected_field_ids.any?
          user.fields = Field.where(id: selected_field_ids)
          user.save
        end
      end
    end
  end


  # GET /resource/edit
   def edit
     if current_user.provider
       render template: 'users/registrations/edit_oauth'
     else
       render :edit
     end
   end

  def update
    @user = current_user
    selected_field_ids = params[:field_ids] || []
    current_field_ids = @user.field_ids

    fields_to_add = Field.where(id: selected_field_ids - current_field_ids)
    fields_to_remove = @user.fields.where.not(id: selected_field_ids)

    fields_to_add.each do |field|
      @user.fields << field unless @user.fields.include?(field)
    end
    @user.fields.delete(fields_to_remove)

    if current_user.provider
      new_username = params[:username]
      if @user.update(username: new_username)
        redirect_to root_path, notice: 'Profile updated successfully'
      else
        redirect_to root_path, notice: "Errore nell'aggiornamento del profilo"
      end
    else
      super
    end
  end
  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end


  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname,field_ids: []])
  end
  #
  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username) }
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
