Rails.application.routes.draw do
  # resources :listings
  get 'sessions/new'
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new', as: 'login'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy', as: 'logout'
  get '/omniauth', to: 'sessions#omniauth'

  post '/omniauth', to: 'sessions#omniauth'
  resources :users do
  	resources :devices
    resources :listings do
    	resources :reservations
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
