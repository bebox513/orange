Rails.application.routes.draw do
  root to: 'tops#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }

  resources :users, :only => [:show] do
    get :search, on: :collection
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :posts, :only => [:show, :new, :create, :edit, :update, :destroy] do
    get :search, on: :collection
    resource :likes, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end

  resources :care_recipients, :only => [:index, :show, :new, :create, :edit, :update] do
    get :search, on: :collection
  end

  resources :comments, :only => [:new, :create, :destroy]
  resources :tops, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:index, :new, :create, :show]
  resources :care_diaries, :only => [:index, :show, :new, :create, :edit, :update]
  resources :care_recipients, :only => [:index, :show, :new, :create, :edit, :update]
end
