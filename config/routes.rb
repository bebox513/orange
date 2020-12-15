Rails.application.routes.draw do
  #削除予定
  root to: 'tops#show'

  devise_for :users

  resources :users, :only => [:show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:new, :create, :show, :index]
end
