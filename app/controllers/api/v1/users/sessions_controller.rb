class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  def new
    authentication_key = User.authentication_keys.first
    user = User.find_for_database_authentication(authentication_key => params[:email])

    if user && user.valid_password?(params[:password])
      token = generate_jwt_token(user)
      render json: {
        status: { code: 200, message: "Logged in successfully." },
        data: UserSerializer.new(user).serializable_hash,
        token: token
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: "Invalid credentials." }
      }, status: :unauthorized
    end
  end
  
  def destroy 
    sign_out(current_user) if user_signed_in?
    respond_to_on_destroy
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.new(resource).serializable_hash,
        token: generate_jwt_token(resource)
      }, status: :ok
    else 
      render json: resource.errors
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def generate_jwt_token(resource)
    payload = {
      user_id: resource.id,
      user_role: resource.role,
      exp: Time.now.to_i + 7.days  
    }
    
    secret_key = Rails.application.credentials.secret_key_base  
    JWT.encode(payload, secret_key, 'HS256')
  end
end
