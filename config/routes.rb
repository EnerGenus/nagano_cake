Rails.application.routes.draw do

  namespace :admin do
    root to: 'homes#top'
  get 'customers/show'
  get 'customers/edit'

  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdraw' => 'customers#withdraw'
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
