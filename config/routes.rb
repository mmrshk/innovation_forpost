# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lit::Engine => '/lit' unless Rails.env.test?

  namespace :admins do
    resources :users, :articles
    resources :attachments
    resources :users
    resources :articles, except: :show
    resources :questions do
      resources :answers
    end
 
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise said he wants to have a specified root rout, so:
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
      registrations: 'registrations'
    }
    resources :articles, only: %i[index show] 
    resources :tags, only: %i[index show]
    root to: "home#index"
    resources :questions
  end

  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable_entity'
  get '/500', to: 'errors#internal_server_error'
end
