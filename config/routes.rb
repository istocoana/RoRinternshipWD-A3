Rails.application.routes.draw do
  root "home#index"
  get "/home", to: "home#index"

  get "/about", to: "static_pages#about"
  get "/blog", to: "static_pages#blog"
  get "/contacts", to: "static_pages#contacts"
  get "/services", to: "static_pages#services"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
