Rails.application.routes.draw do
  devise_for :users
  get '/users/mypage' => 'users#mypage'
  root "recipes#index"
  resources :recipes do
    resources :comments, only: :create
    resources :recipe_likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  resources :materials do
    collection do
      get 'search'
    end
  end
end
