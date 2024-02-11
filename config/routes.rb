Rails.application.routes.draw do
  # ゲストログイン
  devise_scope :customer do
    post 'customer/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

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

  scope module: :public do
  # namespace :public do
    get 'top', to: "homes#top"
    get 'about', to: "homes#about", as: "about"

    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end

    get 'orders/completion', to: "orders#completion"
    post 'orders/confirm', to: "orders#confirm"
    resources :orders, only: [:new, :create, :index, :show] do
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end

    # resources :order_details, only: [:index, :edit, :create, :update, :destroy]
    resources :items
    get "items/ajax_show/:id" , to: "items#ajax_show"
    resources :tags, only: [:index, :show, :destroy]

    get "customers/mypage", to: "customers#show"
    get "customers/information/edit", to: "customers#edit"
    patch "customers/information", to: "customers#update"
    get 'customers/unsubscribe', to: "customers#unsubscribe"
    patch 'customers/withdraw', to: "customers#withdraw"

    resources :seraches, only: [:index, :edit, :create, :update, :destroy]
  end
end
