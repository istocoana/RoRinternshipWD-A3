Rails.application.routes.draw do
<<<<<<< HEAD
=======
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
>>>>>>> 83994c0 (Register and login functionalities)
  root "home#index"

  get "/about", to: "static_pages#about", as: :about
  get "/blog", to: "static_pages#blog"
  get "/contacts", to: "static_pages#contacts"
  get "/services", to: "static_pages#services"
  
  get "/product", to: "products#product"

  get '/services/product_filter_service', to: 'product_filter_service#filter'


  resources :products, only: [:index, :show]

<<<<<<< HEAD
=======
  resources :profiles, only: [:new, :create, :edit, :update]
  get 'profile', to: 'profiles#show', as: :user_profile
  get 'profile_updated', to: 'profiles#updated', as: :profile_updated

>>>>>>> 83994c0 (Register and login functionalities)

end
