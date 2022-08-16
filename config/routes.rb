Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/offers', to: 'offers#index'
  get '/offers/:id', to: 'offers#show'
  post '/bookings', to: 'bookings#create'
  get '/bookings', to: 'bookings#index'

  get '/offers/new', to: 'offers#new'
  post '/offers', to: 'offers#create'
  patch '/bookings/:id', to: 'bookings#update'
  get '/owner/bookings', to: 'owner/bookings#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
