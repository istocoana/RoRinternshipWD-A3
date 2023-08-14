require 'rails_helper'
require 'devise'

RSpec.describe Users::SessionsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    user = FactoryBot.create(:user)
    context 'with valid credentials' do
      it 'signs in the user' do
        post :create, params: { user: { email: user.email, password: user.password } }
        expect(controller).to be_user_signed_in
      end
    end
    context 'with invalid credentials' do
      it 'does not sign in the user' do
        post :create, params: { user: { email: user.email, password: 'wrong_password' } }
        expect(controller).not_to be_user_signed_in
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when a user is signed in' do
      user = FactoryBot.create(:user) 
      it 'destroys a user session and redirects to root_path' do
        sign_in user
        delete :destroy
        expect(controller).not_to be_user_signed_in
      end
    end
  end
end
