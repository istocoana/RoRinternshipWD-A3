class Users::RegistrationsController < Devise::RegistrationsController
    def new
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  def create
    build_resource(sign_up_params)

    if resource.valid? && resource.save
      if resource.role == 'admin'
        handle_registration_success(new_profile_path)
      else
        handle_registration_success(resource.role == 'customer' ? new_profile_path : root_path)
      end
    else
      handle_registration_failure
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, profile_attributes: [:first_name, :last_name, :phone, :street_address, :city, :county]])
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def handle_registration_success(redirect_path)
    sign_up(resource_name, resource)
    set_flash_message! :notice, :signed_up
    redirect_to redirect_path
  end

  def handle_registration_failure
    clean_up_passwords(resource)
    set_minimum_password_length
    flash[:alert] = resource.profile.errors.any? ? "Please correct the errors in the profile form." : nil
    respond_with resource
  end
end

