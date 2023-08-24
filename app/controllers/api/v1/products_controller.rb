class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :require_admin, only: [:index, :edit, :update, :destroy, :create]

  def index
    @products = Product.order(:id)
    @user = User.find_by(role: "admin")
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def new
    @product = Product.create(product_params)
    render json: ProductSerializer.new(@product).serialize
  end

  def edit
    @product = Product.find(params[:id])
    if @product.update(product_params.merge(edited_by: current_user.id))
      render json: { message: 'Product was successfully updated.', product: @product }, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    destroy_order_items(@product)
    
    if @product.destroy
      render json: { message: 'Product was successfully deleted.' }, status: :ok
    else
      render json: { error: 'Error deleting product.' }, status: :unprocessable_entity
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
    params.permit(:title, :description, :price, :vegetarian, :category)
  end  

  def set_product
    @product = Product.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.role == "admin"
      render json: { error: "Access denied." }, status: :forbidden
    end
  end
end
