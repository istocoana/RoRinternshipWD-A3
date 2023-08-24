class Api::V1::OrdersController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :find_products, only: [:create]

  def create
    order = current_user.orders.build(order_date: Date.today, status: 'pending')
  
    @products.each do |product|
      existing_order_item = order.order_items.find_by(product: product)
      
      if existing_order_item
        existing_order_item.quantity += 1
      else
        existing_order_item = order.order_items.build(product: product, quantity: 1, out_of_stock: false)
      end
    end
  
    if order.save
      render json: { message: 'Order created successfully.', cart_items: order.order_items }, status: :created
    else
      render json: { error: 'Failed to create order.' }, status: :unprocessable_entity
    end
  end
  
  def handle
    @order = Order.find(params[:id])
    
    if @order.update(status: "handled")
      render json: { message: "Order has been marked as handled." }, status: :ok
    else
      render json: { error: "Failed to update order status." }, status: :unprocessable_entity
    end
  end
  
  def cart
    cart_orders = current_user.orders.includes(:order_items, :products).where(status: 'pending')
    
    cart_items = cart_orders.flat_map(&:order_items)
    cart_product_count = cart_items.sum(&:quantity)
    
    render json: {
      cart_items: cart_items,
      cart_product_count: cart_product_count
    }, status: :ok
  end
  
  def remove_from_cart
    @order_item = OrderItem.find(params[:order_item_id])

    if @order_item.quantity > 1
      @order_item.quantity -= 1
      @order_item.save
    else
      @order_item.destroy
    end

    response_message = @order_item.destroyed? ? 'Product removed from cart.' : 'Product quantity decreased in cart.'
    cart_items = current_user.orders.where(status: 'pending').flat_map(&:order_items)
    cart_owner = current_user
    cart_product_count = cart_items.sum(&:quantity)
    
    render json: {
      message: response_message,
      cart_items: cart_items,
      cart_owner: cart_owner,
      cart_product_count: cart_product_count
    }, status: :ok
  end

  def complete_order
    @user_processing_orders = current_user.orders.includes(:order_items, :products).where(status: 'processing')
  
    if request.post?
      @user_processing_orders.update(status: 'completed', completed_order_date: Date.today)
      completed_orders = current_user.orders.where(status: 'completed')
  
      render json: { message: 'Orders completed successfully.'}, status: :ok
    else
      render json: { error: 'Invalid request.' }, status: :unprocessable_entity
    end
  end
  
  def completed_orders
    @orders = current_user.orders.where(status: 'completed')
    render json: @orders, include: :order_items
  end

  def orders_page
    @orders = current_user.orders.where(status: ['pending', 'processing', 'completed'])
    render json: @orders, include: :order_items
  end

  def show
    @order = Order.find(params[:id])
    render json: @order
  end

  private

  def find_products
    puts "Params: #{params.inspect}"
    @products = Product.where(id: params[:product_ids])
    puts "Found products: #{@products}"
  end

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
