class ProductsController < ApplicationController
  def product 
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find_by(id: params[40])
  end
end
