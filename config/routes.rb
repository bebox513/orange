Rails.application.routes.draw do
  #削除予定
  root to: 'tops#show'
  
  devise_for :corp_users, controllers: {
    sessions:      'corp_users/sessions',
    passwords:     'corp_users/passwords',
    registrations: 'corp_users/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :user, :only => [:show]
end
