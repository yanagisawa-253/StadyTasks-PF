Rails.application.routes.draw do
  get 'inquiry/index'
  get 'inquiry/confirm'
  get 'inquiry/thanks'
  devise_for :users
  root 'homes#top'
  get '/about' => 'homes#about'

  resources :users, only: [:show, :edit, :update]
  resources :tasks do
    resources :comments, only: [:index, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  # 一覧画面からでもステータス変更できるように
  post '/tasks/:id/done' => 'tasks#done',   as: 'done'

  resources :notifications, only: [:index, :destroy] do
    collection do
        delete 'destroy_all'
    end
  end
  # お問合せ
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
end
