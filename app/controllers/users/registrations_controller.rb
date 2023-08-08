<<<<<<< HEAD
class Users::RegistrationsController < Devise::RegistrationsController
=======
# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
>>>>>>> a48ecfb (Sign out problem)

  def new
    build_resource({})
    resource.build_profile
    respond_with resource
  end

<<<<<<< HEAD
  def create
    build_resource(sign_up_params)

    if resource.valid? && resource.save
      if resource.role == 'customer'
        sign_up(resource_name, resource)
        set_flash_message! :notice, :signed_up
        redirect_to new_profile_path
      else
        sign_up(resource_name, resource)
        set_flash_message! :notice, :signed_up
        redirect_to root_path
      end
    else
      clean_up_passwords(resource)
      set_minimum_password_length
      respond_with resource
    end
  end

  def destroy 
    
  end


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, profile_attributes: [:first_name, :last_name, :phone, :street_address, :city, :county]])
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

=======
  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up) { |user| user.permit(permitted_attributes) }
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_attributes)
  end

  def permitted_attributes
    [
      :email,
      :password,
      :password_confirmation,
      :remember_me,
      :role,
      profile_attributes: %i[first_name last_name phone description]
    ]
  end

  # def create
  #   build_resource(sign_up_params)

  #   if resource.valid? && resource.save
  #     if resource.role == 'customer'
  #       sign_up(resource_name, resource)
  #       set_flash_message! :notice, :signed_up
  #       redirect_to new_profile_path
  #     else
  #       sign_up(resource_name, resource)
  #       set_flash_message! :notice, :signed_up
  #       redirect_to after_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords(resource)
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end

  # private

  # def sign_up_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :role)
  # end


  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

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
>>>>>>> a48ecfb (Sign out problem)
end
