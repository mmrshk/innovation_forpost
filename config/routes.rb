# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'admins/users#index'
  namespace :admins do
    resources :users, :articles
  end
end
