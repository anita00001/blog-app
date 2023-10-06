Rails.application.routes.draw do
  devise_for :users
  post '/posts', to: 'posts#create', as: 'posts'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end

  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resource :likes, only: [:create]
  end

  root to: "users#index"

  delete '/posts/:id', to: 'posts#destroy', as: 'destroy_post'
end
