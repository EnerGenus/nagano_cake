Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    root to: 'homes#top'
    resources :customers, only: [:show, :edit]
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    resources :customers,only: [:show,:edit,:update]
    get  '/customers/unsubscribe' => 'customers#unsubscribe' #確認画面へのパス
    patch '/customers/withdraw' => 'customers#withdraw' #退会処理用のアクションパス
  end


    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
