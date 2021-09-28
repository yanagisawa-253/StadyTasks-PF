Rails.application.routes.draw do
  root 'homes#top'
  get '/about' => 'homes#about'
end
