# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lit::Engine => '/lit'

  namespace :admins do
    resources :users, :articles
    resources :attachments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise said he wants to have a specified root rout, so:
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
      registrations: 'registrations'
    }
    
    root to: "home#index"
  end
end
