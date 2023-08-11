class OrdersController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    order
    existing_order_item = @order.order_items.find_by(product: @product)
  
    if existing_order_item
      existing_order_item.quantity += 1
      if existing_order_item.save
        redirect_to root_path, notice: 'Product added to cart.'
      else
        redirect_to root_path, notice: 'Error'
      end
    else
      @order_item = @order.order_items.new(product: @product, quantity: 1)
      if @order_item.save
        redirect_to root_path, notice: 'Product added to cart.'
      else
        redirect_to root_path, notice: 'Error'
      end
    end
  end

  def cart
    @orders = current_user.orders.includes(:order_items, :products).where(status: ['pending', 'processing'])
    @orders.update_all(status: 'processing') 
  end

  def remove_from_cart
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy

    if request.referrer == root_path
      redirect_to original_url, notice: 'Product removed from cart.'
    else
      redirect_to cart_path, notice: 'Product removed from cart.'
    end
  end

  def complete_order
    @user_processing_orders = current_user.orders.includes(:order_items, :products).where(status: 'processing')
  
    if request.post?
      @user_processing_orders.update(status: 'completed', completed_order_date: Date.today)
      redirect_to completed_orders_path, notice: 'Orders completed successfully.'
    end
  end
  
  def completed_orders
    @orders = current_user.orders.where(status: 'completed')
  end

  def orders_page
    @orders = current_user.orders.where(status: ['processing', 'completed'])
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order
    existing_orders = current_user.orders.where(status: ['pending', 'processing'])

    if existing_orders.empty?
      @order = current_user.orders.create(order_date: Date.today, status: 'pending')
    else
      @order = existing_orders.first
    end
  end

end

