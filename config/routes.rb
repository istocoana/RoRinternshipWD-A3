
Rails.application.routes.draw do
  get 'current_user/index'
  
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root "home#index"
  get "/about", to: "static_pages#about", as: :about
  get "/blog", to: "static_pages#blog"
  get "/contacts", to: "static_pages#contacts"
  get "/services", to: "static_pages#services"
  get '/services/product_filter_service', to: 'product_filter_service#filter'
  get 'profile', to: 'profiles#show', as: :user_profile
  get 'profile_updated', to: 'profiles#updated', as: :profile_updated
  get 'add_to_cart/:product_id', to: 'orders#create', as: 'add_to_cart'
  get 'cart', to: 'orders#cart'
  post 'complete_order', to: 'orders#complete_order', as: 'complete_order'
  get 'completed_orders', to: 'orders#completed_orders', as: 'completed_orders'
  get "orders_page", to: "orders#orders_page", as: "orders_page"
  get 'admin/orders', to: 'admin#orders', as: 'admin_orders'
  
  resources :orders, only: [:show] do
    collection do
      delete 'remove_from_cart/:order_item_id', action: :remove_from_cart, as: :remove_from_cart
    end
  end

  resources :products
  resources :profiles, only: [:new, :create, :edit, :update]
  resources :orders do
    member do
      patch :handle, to: 'orders#handle'
    end
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: { registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }    
      resources :products
      resources :profiles, only: [:new, :create, :edit, :update]
      resources :orders do
        member do
          patch :handle, to: 'orders#handle'
          post :remove_from_cart, to: 'orders#remove_from_cart'
          post :complete_order, to: "orders@complete_orders"
        end
      end
      resources :admin do
        collection do
          get :all_users
        end
      end
      get '/services/product_filter_service', to: 'product_filter_service#filter'
      get 'profile', to: 'profiles#show', as: :user_profile
      get 'profile/new', to: "profiles#new", as: "new_profile"
      get 'profile_updated', to: 'profiles#updated', as: :profile_updated
      post 'add_to_cart', to: 'orders#create', as: 'add_to_cart'
      get 'cart', to: 'orders#cart'
      post 'complete_order', to: 'orders#complete_order', as: 'complete_order'
      get 'completed_orders', to: 'orders#completed_orders', as: 'completed_orders'
      get "orders_page", to: "orders#orders_page", as: "orders_page"
      get 'admin/orders', to: 'admin#orders', as: 'admin_orders'
      root "home#index"
    end
  end


end
