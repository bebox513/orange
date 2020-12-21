Rails.application.routes.draw do
  #削除予定
  root to: 'tops#show'

  devise_for :users


  resources :users, :only => [:show] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :messages, :only => [:create]
  resources :rooms, :only => [:new, :create, :show, :index]
end
