Rails.application.routes.draw do
  get 'admins/users_show'
  get 'admins/articles_show'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'users#index'
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/admin_users', to: 'admins#users_show'
  #get '/admin_articles', to: 'admins#articles_show'
end
