Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update]
  
  # brandsにpostをネストさせる
  resources :brands, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create]
  end
  # brandに属さない操作は個別に
  resources :posts, only: [:show, :edit, :update, :destroy]
end