class ApplicationController < ActionController::Base
  before_action :store_location
  def store_location
    unless params[:controller] == "devise/sessions"
      url = root_path
      session[:user_return_to] = url
    end
  end

  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
