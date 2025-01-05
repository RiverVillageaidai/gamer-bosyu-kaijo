Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get 'homes/about'

  resources :users, only: [:show, :edit, :update] do
    member do
      # ユーザー退会確認画面
      get 'deactivate' => 'users#deactivate'
      # ユーザー退会　論理削除
      patch 'withdraw' => 'users#withdraw'
    end
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
