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

end
