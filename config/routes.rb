Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get '/about' => 'homes#about'
  
  resources :users, only: [:show, :edit, :update]
  resources :tasks do
    resources :comments, only: [ :index, :create, :destroy]
  end
end
