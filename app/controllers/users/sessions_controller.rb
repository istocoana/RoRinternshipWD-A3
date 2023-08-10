class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def destroy 
    sign_out(current_user) if user_signed_in?
    redirect_to root_path, notice: 'You have been signed out successfully.'
  end

end
