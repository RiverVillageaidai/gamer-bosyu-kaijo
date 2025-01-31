Rails.application.routes.draw do

  devise_for :admin, 
  skip: [:registrations, :password], #サインアップとパスワード設定機能をスキップ
  controllers: {sessions: 'admin/sessions'}

  namespace :admin do
    get 'dashboards', to: 'dashboards#top'
    resources :users, only: [:show,:index] do
      member do
        patch 'withdraw' => 'users#withdraw'
        patch 'rejoin' => 'users#rejoin'
      end
    end 
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end

  end



  scope module: :public do
    devise_for :users, controllers: { sessions: 'public/sessions' } #Deviseのデフォルトのsessionsコントローラーをカスタムコントローラー(public/sessions)に置き換え

    root to: 'homes#top'
  
    get 'homes/about'

    #検索ボタンが押された時、Searchesコントローラーのsearch実行
    get "search" => "searches#index"

    resources :users, only: [:index,:show, :edit, :update ] do
      resource :relationships, only: [:create, :destroy] #フォロー機能
      member do
        get "followings" => "relationships#followings",as: "followings" #フォロー一覧
  	    get "followers" => "relationships#followers",as: "followers" #フォロワー一覧
        get 'deactivate' => 'users#deactivate' # ユーザー退会確認画面
        patch 'withdraw' => 'users#withdraw' # ユーザー退会　論理削除
      end
    end

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end

    resources :groups, only: [:index, :show, :new, :create, :edit, :update] do 
      resource :group_members, only: [:create, :destroy]
      resource :group_join_requests, only: [:create, :destroy]
    end
    get "groups/:id/display_join_requests" => "groups#display_join_requests", as: :display_join_requests
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
