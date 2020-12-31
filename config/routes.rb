Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  get '/users/mypage' => 'users#mypage'
  root "homes#show"
  resources :homes, only: [:show]
  resources :recipes do
    resources :comments, only: :create
    resources :recipe_likes, only: %i[create destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: %i[index show]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :relationships, only: %i[create destroy]
  resources :materials do
    resources :material_comments, only: :create
    resources :material_likes, only: %i[create destroy]
    collection do
      get 'search'
    end
  end
end
