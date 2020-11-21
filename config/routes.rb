Rails.application.routes.draw do
  devise_for :users
  get '/users/mypage' => 'users#mypage'
  root "homes#show"
  resources :homes, only: [:show]
  resources :recipes do
    resources :comments, only: :create
    resources :recipe_likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
  resources :materials do
    collection do
      get 'search'
    end
  end
end
