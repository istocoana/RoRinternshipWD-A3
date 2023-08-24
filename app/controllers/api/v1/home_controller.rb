class Api::V1::HomeController < Api::V1::ApplicationController
  def index     
    @selected_category = params[:category] || "Category"
    @vegetarian = params[:vegetarian] || 'Vegetarian'
    @sorting = params[:order_by] || 'Sorting'

    @products = ProductFilterService.new(category: @selected_category, vegetarian: @vegetarian, sorting: @sorting).filter

    @orders = Order.all

    render json: @products
  end
end
