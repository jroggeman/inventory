Rails.application.routes.draw do
  resources :users, except: :index
  resources :boxes

  # Login routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
