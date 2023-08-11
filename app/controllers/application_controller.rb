class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :store_location
  # before_action :authenticate_user!
  
  
  def store_location
    unless params[:controller] == "devise/sessions"
      session[:user_return_to] = root_path unless params[:controller] == "devise/sessions"
    end
  end

  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
