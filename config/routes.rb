Rails.application.routes.draw do
  resources :users

  # Login routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
