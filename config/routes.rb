Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update]
  
  # brandsに紐付けてpostsを定義
  resources :brands, only: [:index] do
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
end
