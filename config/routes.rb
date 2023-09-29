Rails.application.routes.draw do
  post '/posts', to: 'posts#create', as: 'posts'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end
end
