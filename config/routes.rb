Rails.application.routes.draw do
  devise_for :users
  root to: "admins#users_show"
  #resources :admins
  get     'admins/users_show',    to: 'admins#users_show'
  get     'admins/articles_show', to: 'admins#articles_show'
  get     'admins/:id',           to: 'admins#show',    as: 'user'
  get     'admins/:id/edit',      to: 'admins#edit',    as: 'edit_user'
  patch   'admins/:id',           to: 'admins#update'
  delete  'admins/:id',           to: 'admins#destroy', as: 'delete_user'

end
