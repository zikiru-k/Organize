Rails.application.routes.draw do
  devise_for :users
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    get 'top', to: "homes#top"
    get 'about', to: "homes#about", as: "about"

    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end

    get 'orders/completion', to: "orders#completion"
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm', to: "orders#confirm"

    resources :order_details, only: [:index, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :goods, only: [:create, :destroy]
    end

    resources :seraches, only: [:index, :edit, :create, :update, :destroy]
    resources :items
    resources :websites

    get "customers/mypage", to: "customers#show"
    get "customers/information/edit", to: "customers#edit"
    patch "customers/information", to: "customers#update"
    get 'customers/unsubscribe', to: "customers#unsubscribe"
    patch 'customers/withdraw', to: "customers#withdraw"

  end
end
