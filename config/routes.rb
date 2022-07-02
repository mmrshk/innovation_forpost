Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise said he wants to have a specified root rout, so:
  root to: "admins#users_show"
  #resources :admins
  get     'admins/users_show', to: 'admins#users_show'
  get     'admins/articles_show', to: 'admins#articles_show'
  get     'admins/:id', to: 'admins#show', as: 'user'
  get     'admins/:id/edit', to: 'admins#edit', as: 'edit_user'
  patch   'admins/:id', to: 'admins#update'

end
