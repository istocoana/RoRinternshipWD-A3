require 'jwt'

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    build_resource(sign_up_params)
    resource.build_profile
    respond_with(resource)
  end

  def create
    resource.build_resource(sign_up_params)   
    if resource.save
      if resource.role == 'admin'
        handle_registration_success(new_api_v1_profile_path)
      else
        handle_registration_success(resource.role == 'customer' ? new_api_v1_profile_path : root_path)
      end
    else
      puts resource.errors.full_messages
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
    respond_with(resource)
    set_flash_message! :notice, :signed_up
  end

  def handle_registration_failure
    clean_up_passwords(resource)
    set_minimum_password_length
    flash[:alert] = resource.errors.any? ? "Please correct the errors in the profile form." : nil
    respond_with_failure(resource)
  end

  def respond_with(resource)   
    render json: {
      status: { code: 200, message: "Signed up successfully." },
      data: UserSerializer.new(resource).serializable_hash,
      token: generate_jwt_token(resource)
    }, status: :ok
  end
  
  def respond_with_failure(resource)
    render json: {
      status: { code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
    }, status: :unprocessable_entity
  end

  def generate_jwt_token(user)
    payload = {
      email: user.email,
      role: user.role,
      exp: Time.now.to_i + 7.days  
    }
    secret_key = Rails.application.credentials.secret_key_base 
    JWT.encode(payload, secret_key, 'HS256')
  end
end
