Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_closed', on: :member
  end

  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  post 'places', to:'places#search'
  delete 'signout', to: 'sessions#destroy'

end
