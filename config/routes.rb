
Rails.application.routes.draw do
  
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


end
