Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update] do
    member do
      delete :destroy_account
    end
  end
  
  # brandsにpostをネストさせる
  resources :brands, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create]
  end
  # brandに属さない操作は個別に
  resources :posts, only: [:show, :edit, :update, :destroy]do
    collection do
        get 'search' # posts/search というURLで検索結果を出す
    end
    resources :post_comments, only: [:create, :destroy]
  end

  
end