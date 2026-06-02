
Rails.application.routes.draw do
  devise_for :users
  
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update]
  resources :brands, only: [:index]
  resources :posts
end