# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#top'

  resources :posts, only: [:index, :show, :new, :create, :destroy] 
end
