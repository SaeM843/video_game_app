Rails.application.routes.draw do
  devise_for :users

  namespace :owner do
    resources :bookings, only: :index
  end

  root to: "pages#home"

  get '/offers', to: 'offers#index'
  get '/offers/:id', to: 'offers#show', as: :offer
  post '/bookings', to: 'bookings#create'
  get '/bookings', to: 'bookings#index'

  get '/offers/new', to: 'offers#new'
  post '/offers', to: 'offers#create'
  patch '/bookings/:id', to: 'bookings#update'
  get '/owner/bookings', to: 'owner/bookings#index'
end
