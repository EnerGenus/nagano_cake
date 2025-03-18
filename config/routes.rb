Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    root to: 'homes#top'
  get 'customers/show'
  get 'customers/edit'
  end

  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customer , only:[:edit,:create,:destroy,:update]
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
