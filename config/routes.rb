Rails.application.routes.draw do
  
  root "home#index"

  get "/about", to: "static_pages#about"
  get "/blog", to: "static_pages#blog"
  get "/contacts", to: "static_pages#contacts"
  get "/services", to: "static_pages#services"
  get "/product", to: "products#product"
  get '/services/product_filter_service', to: 'product_filter_service#filter'
  resources :products, only: [:index, :show]

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'sessions' }

  resources :profiles, only: [:new, :show, :create]  
  get 'profile', to: 'profiles#show', as: :user_profile

end
