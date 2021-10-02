Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get '/about' => 'homes#about'

  resources :users, only: [:show, :edit, :update]
  resources :tasks do
    resources :comments, only: [ :index, :create, :destroy]
    # resources :likes, only: [:create, :destroy]
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
end
