require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:user, role: 'admin') }
  product = FactoryBot.create(:product)

  describe 'GET #index' do
    context 'when user is an admin' do
      before do
        allow(controller).to receive(:current_user).and_return(admin_user)
      end

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'when user is not an admin' do
      before do
        customer_user = FactoryBot.create(:user, role: 'customer')
        allow(controller).to receive(:current_user).and_return(customer_user)
      end

      it 'redirects with an alert' do
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: product.id}
      expect(response).to be_successful
    end

    it 'assigns @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do 
      get :new 
      expect(response).to be_successful 
    end
    
    it 'assings a new product to @product' do
      get :new 
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    context 'when the arrtributes are valid' do
      before do
        allow(controller).to receive(:current_user).and_return(admin_user)
      end
      it 'creates a new product' do
        product_attributes = FactoryBot.attributes_for(:product)
        expect {
          post :create, params: { product: product_attributes }
        }.to change(Product, :count).by(1)
      end
    end
  end


  
  
end
