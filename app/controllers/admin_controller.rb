class AdminController < ApplicationController
  before_action :authenticate_admin!

  def orders
    @orders = Order.all
  end

  private
  
  def authenticate_admin! 
    unless current_user.role == "admin"
      redirect_to root_path, alert: "Access denied."
    end
  end
end
