Rails.application.routes.draw do\

  # ゲストログイン
  devise_scope :customer do
    post 'customer/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # devise_for :customer, controllers: {
  #   registrations: 'customer/registrations'
  # }

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

  namespace :admin do
  # scope module: :admin do
    resources :groups, only: [:index, :show, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      resources :orders, only: [:index, :show, :edit, :update] do
        resources :comments, only: [:create, :destroy] do
          resource :bookmarks, only: [:create, :destroy]
        end
      end
      resources :items, only: [:index, :show, :edit, :update, :destroy] do
        collection do
          get 'search'
        end
      end
      resources :tags, only: [:index, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
  # namespace :public do
    get 'top', to: "homes#top"
    get 'about', to: "homes#about", as: "about"

    resources :groups do
      resource :group_users, only: [:create, :destroy]
      resources :orders, only: [:new, :create, :index, :show] do
        resources :comments, only: [:create, :destroy] do
          resource :bookmarks, only: [:create, :destroy]
        end
      end
      get "items/favorite_index" , to: "items#favorite_index"
      resources :items do
        collection do
          get 'search'
        end
        resource :favorites, only: [:create, :destroy]
      end
      get "items/ajax_show/:id" , to: "items#ajax_show"
      resources :tags, only: [:index, :destroy]
    end

    get "customers/mypage", to: "customers#show"
    get "customers/information/edit", to: "customers#edit"
    patch "customers/information", to: "customers#update"
    get 'customers/unsubscribe', to: "customers#unsubscribe"
    patch 'customers/withdraw', to: "customers#withdraw"
  end

  root to: "public/homes#top"
end
