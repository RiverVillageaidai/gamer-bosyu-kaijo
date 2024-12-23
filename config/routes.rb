Rails.application.routes.draw do

  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  devise_for :users

  root to: 'homes#top'
  get 'homes/about'

  resources :users, only: [:show, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
