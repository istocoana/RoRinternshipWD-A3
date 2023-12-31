class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :edit, :update, :destroy, :create]

  def index
    @products = Product.order(:id)
    @user = User.find_by(role: "admin")
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.photo.attach(params[:product][:photo]) if params[:product][:photo]

    if @product.save
      redirect_to product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
    
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params.merge(edited_by: current_user.id))
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit, alert: 'Error creating a new product'
    end
  end 

  def destroy
    @product = Product.find(params[:id])

    if @product
      destroy_order_items(@product)
      
      if @product.destroy
        redirect_to products_path, notice: 'Product was successfully deleted.'
      else
        redirect_to products_path, alert: 'Error deleting product.'
      end
    else
      redirect_to products_path, alert: 'Product not found.'
    end
  end

  private

  def destroy_order_items(product)
    orders_to_update = Order.processing.includes(:order_items).where(order_items: { product: product })

    orders_to_update.each do |order|
      order_item = order.order_items.find_by(product: product)
      order_item&.destroy
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :vegetarian, :category, :photo)
  end  

  def set_product
    @product = Product.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.role == "admin"
      redirect_to root_path, alert: "Access denied."
    end
  end

end
