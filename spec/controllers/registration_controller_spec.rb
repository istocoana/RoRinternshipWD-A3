require 'rails_helper'
require 'devise'

RSpec.describe  Users::RegistrationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  let(:valid_params) do
    {
      user:  FactoryBot.attributes_for(:user)
    }
  end
  user = FactoryBot.create(:user)

  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to new_profile_path for users' do
        post :create, params: valid_params 
        expect(response).to redirect_to(new_profile_path)
      end

      it 'redirects to root_path for roles other than customer' do
        admin_params = valid_params.deep_dup
        admin_params[:user][:role] = 'admin'
        post :create, params: admin_params
        expect(response).to redirect_to(new_profile_path)
      end
    end

    context 'with invalid params' do
      it 're-renders sign up template' do 
        invalid_user_params = FactoryBot.attributes_for(:user, email: 'invalid email')
        post :create, params: { user: invalid_user_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the user account' do
      sign_in user 
      expect { delete :destroy }.to change(User, :count).by(-1) 
    end
  end

end
