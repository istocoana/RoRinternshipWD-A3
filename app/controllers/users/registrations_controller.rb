class Users::RegistrationsController < Devise::RegistrationsController
    def new
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  def create
    build_resource(sign_up_params)
  
    if resource.valid? && resource.save
      if resource.role == 'customer'
        sign_up(resource_name, resource)
        set_flash_message! :notice, :signed_up
        redirect_path = resource.role == 'customer' ? new_profile_path : root_path
        redirect_to redirect_path and return
      end
    end
  
    clean_up_passwords(resource)
    set_minimum_password_length
    respond_with resource
  end
  
  

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, profile_attributes: [:first_name, :last_name, :phone, :street_address, :city, :county]])
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
