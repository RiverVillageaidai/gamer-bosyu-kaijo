Rails.application.routes.draw do

  devise_for :admin, 
  skip: [:registrations, :password], #サインアップとパスワード設定機能をスキップ
  controllers: {sessions: 'admin/sessions'}

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  scope module: :public do
    devise_for :users, controllers: { sessions: 'public/sessions' } #Deviseのデフォルトのsessionsコントローラーをカスタムコントローラー(public/sessions)に置き換え

    root to: 'homes#top'
  
    get 'homes/about'

    #検索ボタンが押された時、Searchesコントローラーのsearch実行
    get "search" => "searches#index"

    resources :users, only: [:show, :edit, :update, :index] do
     member do
        # ユーザー退会確認画面
       get 'deactivate' => 'users#deactivate'
        # ユーザー退会　論理削除
       patch 'withdraw' => 'users#withdraw'
     end
    end

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
