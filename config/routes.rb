# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise said he wants to have a specified root rout, so:
  root to: 'home#index'
  resources :articles
end
