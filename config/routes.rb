Rails.application.routes.draw do
  devise_for :users
  root to: "admins/users#index"
  namespace :admins do
    resources :users, :articles
  end

  #get     '/admins/users_show',    to: 'admins#users_show'
  #get     '/admins/articles_show', to: 'admins#articles_show'
  #get     '/admins/:id',           to: 'admins#show',    as: 'user'
  #get     '/admins/:id/edit',      to: 'admins#edit',    as: 'edit_user'
  #patch   '/admins/:id',           to: 'admins#update'
  #delete  '/admins/:id',           to: 'admins#destroy', as: 'delete_user'
  #get     '/admins/new',           to: 'admins#new',     as: 'new_user'
  #post    '/admins',               to: 'admins#create'

end
