Rails.application.routes.draw do
  #削除予定
  root to: 'tops#show'

  devise_for :users


  resources :users do
    resources :users, :only => [:show]
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end

  resources :messages, :only => [:create]
  resources :rooms, :only => [:new, :create, :show, :index]
end
