require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  describe 'POST #create' do
    context 'when the product is found' do
      before do
        sign_in user
      end
      it 'increases the quantity of an existing order item' do
        order = user.orders.create(order_date: Date.today, status: 'pending') 
        order_item = FactoryBot.create(:order_item, order: order, product: product, quantity: 1) 
        post :create, params: { product_id: product.id }
        expect(order_item.reload.quantity).to eq(2)
      end
      it 'creates a new order item' do
        sign_in user
        post :create, params: { product_id: product.id }
        expect(user.orders.last.order_items.count).to eq(1)
        expect(user.orders.last.order_items.first.product).to eq(product)
      end
    end
  end

  describe 'PATCH #handle' do
    let(:order) { FactoryBot.create(:order) }
    it 'updates the status of the order to "handled"' do
      sign_in user
      patch :handle, params: { id: order.id }
      order.reload
      expect(order.status).to eq('handled')
      expect(response).to redirect_to(admin_orders_path)
      expect(flash[:notice]).to eq('Order has been marked as handled.')
    end
  end

  describe 'GET #cart' do
    let(:order) { FactoryBot.create(:order) }
    it 'updates the status of orders to "processing" and renders the cart template' do
      sign_in user
      orders = FactoryBot.create_list(:order, 2, user: user, status: 'pending')
      get :cart
      orders.each(&:reload)
      expect(orders.all? { |o| o.status == 'processing' }).to be(true)
      expect(response).to render_template(:cart)
    end
  end

  describe 'PATCH #remove_from_cart' do
    let(:order) { FactoryBot.create(:order, user: user, status: 'pending') }
    let!(:order_item) { FactoryBot.create(:order_item, order: order, product: product, quantity: 2) } 

    it 'decreases the quantity of an existing order item' do
      sign_in user

      patch :remove_from_cart, params: { order_item_id: order_item.id }

      order_item.reload
      expect(order_item.quantity).to eq(1)
      expect(response).to redirect_to(cart_path)
      expect(flash[:notice]).to eq('Product quantity decreased in cart.')
    end

    it 'removes the order item when quantity becomes 0' do
      sign_in user
      patch :remove_from_cart, params: { order_item_id: order_item.id }
      order_item.destroy
      expect(OrderItem.find_by(id: order_item.id)).to be_nil
      expect(response).to redirect_to(cart_path)
      expect(flash[:notice]).to eq('Product quantity decreased in cart.')
    end

    it 'redirects to the original referrer if it is root_path' do
      sign_in user
      request.env['HTTP_REFERER'] = root_path
      patch :remove_from_cart, params: { order_item_id: order_item.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Product quantity decreased in cart.')
    end
  end

  describe '#complete_order' do
    let(:user) { FactoryBot.create(:user) }
    let!(:processing_order) { FactoryBot.create(:order, user: user, status: 'processing') }
    let!(:completed_order) { FactoryBot.create(:order, user: user, status: 'completed', completed_order_date: Date.new(2023, 5, 14)) }

    before { sign_in(user) }
    context 'when completing orders' do
      it 'marks processing orders as completed' do
        post :complete_order
        expect(response).to redirect_to(completed_orders_path)
        expect(processing_order.reload.status).to eq('completed')
        expect(processing_order.completed_order_date).to eq( Date.today)
      end

      it 'does not affect completed orders' do
        post :complete_order
        expect(completed_order.reload.status).to eq('completed')
        expect(completed_order.completed_order_date).to eq(Date.new(2023, 5, 14))
      end

      it 'displays a success notice' do
        post :complete_order
        expect(flash[:notice]).to eq('Orders completed successfully.')
      end
    end
  end

  describe '#completed_orders' do
    let(:user) { FactoryBot.create(:user) }
    before { sign_in(user) }
    it 'fetches only completed orders for the current user' do
      completed_order = FactoryBot.create(:order, user: user, status: 'completed', completed_order_date: Date.new(2023, 5, 14))
      processing_order = FactoryBot.create(:order, user: user, status: 'processing')
      get :completed_orders
      expect(assigns(:orders)).to eq([completed_order])
    end
  end

  describe '#orders_page' do
    let(:user) { FactoryBot.create(:user) }
    before { sign_in(user) }
    it 'fetches both processing and completed orders for the current user' do
      completed_order = FactoryBot.create(:order, user: user, status: 'completed', completed_order_date: Date.new(2023, 5, 14))
      processing_order = FactoryBot.create(:order, user: user, status: 'processing')
      get :orders_page
      expect(assigns(:orders)).to eq([completed_order, processing_order])
    end
  end

  describe '#show' do
    let(:user) { FactoryBot.create(:user) }
    before { sign_in(user) }
    it 'fetches the correct order for the given ID' do
      order = FactoryBot.create(:order, user: user)
      get :show, params: { id: order.id }
      expect(assigns(:order)).to eq(order)
    end
  end
end
