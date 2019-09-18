Rails.application.routes.draw do
  resources :items, only: :index
  resources :users, only: :create
  resources :sessions, only: [:create, :destroy]
end
