Rails.application.routes.draw do
  root to: 'tops#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
   
  resources :users, :only => [:show] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :tops, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:new, :create, :show, :index]
  resources :care_diaries, :only => [:index, :show, :new, :create, :edit, :update]
  resources :care_recipients, :only => [:index, :show, :new, :create, :edit, :update]
end
