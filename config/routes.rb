Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    root to: 'homes#top'
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:index]
  end
  
  scope module: :public do
    root 'homes#top'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    get 'homes/about' => 'homes#about', as: 'about'
    resources :items, only: [:index, :show]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    get 'customers/information' => 'customer#update'
    get  'customers/unsubscribe' => 'customers#unsubscribe', as:'unsubscribe' #確認画面へのパス
    patch 'customers/withdraw' => 'customers#withdraw', as:'withdraw' #退会処理用のアクションパス
  end

  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end