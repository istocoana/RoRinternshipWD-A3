class HomeController < ApplicationController
  
  def index 
    @products = ProductFilterService.new(params).filter
    
    @selected_category = params[:category] || "Category"
    @vegetarian = params[:vegetarian] || 'Vegetarian'

    @orders = Order.all
   
  end
end
