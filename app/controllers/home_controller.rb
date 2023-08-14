class HomeController < ApplicationController
  def index 
    @products = ProductFilterService.new(params).filter
    
    @selected_category = params[:category] || "Category"
    @vegetarian = params[:vegetarian] || 'Vegetarian'
    @sorting = params[:order_by] || 'Sorting'
    
    @orders = Order.all
  end
end
