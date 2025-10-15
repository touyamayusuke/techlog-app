Rails.application.routes.draw do
  devise_for :users
  root 'home#top'

  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:show]
end
