# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root to: 'home#index'
  namespace :admins do
    resources :users, :articles
  end
end
