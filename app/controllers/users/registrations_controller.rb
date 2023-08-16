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
      if params[:user][:field_ids].present?
        selected_field_ids = params[:user][:field_ids].reject(&:blank?)
  
        if selected_field_ids.any?
          user.fields = Field.where(id: selected_field_ids)
        end
      end
    end
  end
  

  # GET /resource/edit
  # def edit
  #   super
  # end

  def update
    super do |user|
      selected_field_ids = params[:user][:field_ids] || []
      current_field_ids = user.field_ids
  
      fields_to_add = Field.where(id: selected_field_ids - current_field_ids)
      fields_to_remove = user.fields.where.not(id: selected_field_ids)
  
      user.fields << fields_to_add
      user.fields.delete(fields_to_remove)
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

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
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
