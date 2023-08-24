class Api::V1::ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :store_location
  
  def store_location
    unless params[:controller] == "devise/sessions"
      session[:user_return_to] = root_path
    end    
  end

  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def authenticate_user! 
    token = request.headers['Authorization'] 
  
    if token
      secret_key = Rails.application.credentials.secret_key_base
      decoded_token = JWT.decode(token.split(' ').last, secret_key, true, algorithm: 'HS256') rescue nil
      
      if decoded_token
        user_id = decoded_token[0]['user_id']  
        @current_user = User.find(user_id)     
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token missing' }, status: :unauthorized
    end
  end
end
