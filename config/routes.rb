# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lit::Engine => '/lit'

  devise_for :users, :controllers => {
    registrations: 'registrations'
  }
  root to: "home#index"
  namespace :admins do
    resources :users, :articles
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise said he wants to have a specified root rout, so:
  
end
