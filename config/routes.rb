Rails.application.routes.draw do
  resources :items, only: :index
  resources :users, only: :create
  resource :sessions, only: [:create, :destroy]
end
