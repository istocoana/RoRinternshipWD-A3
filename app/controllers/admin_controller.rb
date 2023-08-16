class AdminController < ApplicationController
  before_action :authenticate_admin!

  def orders
    @orders = Order.all
    @product = Product.all
    default_order_by = 'status'

    if params[:order_by] == 'price'
      @orders = @orders.sort_by(&:total_price)
    elsif params[:order_by] == 'status'
      @orders = @orders.order(status: :asc)
    elsif params[:order_by] == 'order_date'
      @orders = @orders.order(order_date: :asc)
    elsif params[:order_by] == 'user_id'
      @orders = @orders.order(user_id: :asc)
    else
      @orders = @orders.order(default_order_by.to_sym => :asc)
    end
  end
  
  private
  
  def authenticate_admin! 
    unless current_user.role == "admin"
      redirect_to root_path, alert: "Access denied."
    end
  end
end
