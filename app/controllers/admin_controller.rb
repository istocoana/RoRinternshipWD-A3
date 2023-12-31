class AdminController < ApplicationController
  before_action :authenticate_admin!
  
  def orders
    @product = Product.all

    default_order_by = 'status'

    @orders = Order.all
    @orders = case params[:order_by]
              when 'price'
                @orders.sort_by(&:total_price)
              when 'status'
                @orders.order(status: :asc)
              when 'order_date'
                @orders.order(order_date: :asc)
              when 'user_id'
                @orders.order(user_id: :asc)
              else
                @orders.order(default_order_by.to_sym => :asc)
              end
  end

  private

  def authenticate_admin! 
    redirect_to root_path, alert: "Access denied." unless current_user.role == "admin"
  end
end
