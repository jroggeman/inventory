Rails.application.routes.draw do
  root to: 'boxes#index'

  resources :users, except: :index
  resources :boxes

  # Login routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
