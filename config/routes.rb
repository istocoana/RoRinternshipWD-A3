Rails.application.routes.draw do
  root "home#index"

  get "/about", to: "static_pages#about"
  get "/blog", to: "static_pages#blog"
  get "/contacts", to: "static_pages#contacts"
  get "/services", to: "static_pages#services"
  
  get "/product", to: "products#product"

  resources :products, only: [:index, :show]


end
