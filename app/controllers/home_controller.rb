class HomeController < ApplicationController
  def index 
    @products = ProductFilterService.new(params).filter

    @products = filter_by_category(@products, params[:category])
    @products = filter_by_vegetarian(@products, params[:vegetarian])

    @selected_category = params[:category] || "Category"
    @vegetarian = params[:vegetarian] || 'Vegetarian'

  end

  private

  def filter_by_category(products, category)
    if category == "Category" || category.nil?
      products = Product.all
    else
      products = products.where(category: category)
    end
    products
  end

  def filter_by_vegetarian(products, vegetarian)
    if vegetarian.nil? || vegetarian == 'Vegetarian'
      products = Product.all
    else
      is_vegetarian = vegetarian == 'true' ? true : false
      products = products.where(vegetarian: is_vegetarian)
    end
    products
  end
end
