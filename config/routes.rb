Rails.application.routes.draw do
  get "diagnoses/new"
  get "diagnoses/create"
  get "diagnoses/result"


  get 'diagnoses/new', to: 'diagnoses#new'
  post 'diagnoses/create', to: 'diagnoses#create'
  get 'diagnoses/result', to: 'diagnoses#result'

  resources :diagnoses, only: [:new, :create]
  
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
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get "homes/top"
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :posts, only: [:index, :show, :edit, :update, :destroy] do
        member do
          patch :clear_review
        end
      end
   end
  end


  
end