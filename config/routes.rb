Rails.application.routes.draw do
  resources :items, only: :index
  resources :users, only: :create
  resource :sessions, only: %i[create destroy]
end
