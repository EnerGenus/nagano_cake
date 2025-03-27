Rails.application.routes.draw do

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get  'customers/unsubscribe' => 'customers#unsubscribe', as:'unsubscribe' #確認画面へのパス
    patch 'customers/withdraw' => 'customers#withdraw', as:'withdraw' #退会処理用のアクションパス
    get 'orders/done'
    post 'orders/confirm'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
  end

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 検索機能のルーティング
  get 'search', to: 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end