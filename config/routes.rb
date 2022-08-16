Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/index', to: 'offers#index'
  get '/offers/new', to: 'offers#new'
  post '/offers', to: 'offers#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
