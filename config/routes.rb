Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update]
  resources :brands, only: [:index]
  
  # ご提示のURL設計通りにフラットな階層で定義
  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
end