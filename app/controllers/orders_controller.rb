class OrdersController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    order
  
    begin
      if @product
        existing_order_item = @order.order_items.find_by(product: @product)
      
        if existing_order_item
          existing_order_item.quantity += 1
          if existing_order_item.save
            redirect_to root_path, notice: 'Product added to cart.'
          else
            redirect_to root_path, notice: 'Error updating cart.'
          end
        else
          @order_item = @order.order_items.new(product: @product, quantity: 1, out_of_stock: false)
          if @order_item.save
            redirect_to root_path, notice: 'Product added to cart.'
          else
            redirect_to root_path, notice: "Error adding product to cart."
          end
        end
      else
        redirect_to root_path, notice: 'Product not found.'
      end
    rescue => ex
      redirect_to root_path, notice: "Error adding product to cart: #{ex.message}"
    end
  end
  
  def handle
    @order = Order.find(params[:id])
    @order.update(status: "handled")
    redirect_to admin_orders_path, notice: "Order has been marked as handled."
  end
  
  def cart
    @orders = current_user.orders.includes(:order_items, :products).where(status: ['pending', 'processing'])
    @orders.update_all(status: 'processing') 
  end

  def remove_from_cart
    @order_item = OrderItem.find(params[:order_item_id])
    
    if @order_item.quantity > 1
      @order_item.quantity -= 1
      @order_item.save
    else
      @order_item.destroy
    end
  
    if request.referrer == root_path
      redirect_to original_url, notice: 'Product quantity decreased in cart.'
    else
      redirect_to cart_path, notice: 'Product quantity decreased in cart.'
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

  def mark_order_item_as_out_of_stock(product)
    orders_to_update = Order.processing.includes(:order_items).where(order_items: { product: product })

    orders_to_update.each do |order|
      order_item = order.order_items.find_by(product: product)
      order_item&.update(out_of_stock: true)
    end
  end

end



