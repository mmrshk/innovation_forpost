# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lit::Engine => '/lit' unless Rails.env.test?

  namespace :admins do
    resources :users
    resources :attachments
    resources :questions, except: %i[create new] do
      resources :answers, only: %i[create destroy]
    end

    resources :articles, except: :show do
      collection do
        post :upload
      end
    end

    resources :companies, except: :show
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise said he wants to have a specified root rout, so:

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
      registrations: 'registrations'
    }
    root to: "home#index"
    get 'about', to: 'home#about'

    resources :articles, only: %i[index show]
    resources :tags, only: %i[index show]
    resources :questions, only: %i[index new create show]
    resources :attachments, only: %i[show download]
    resources :companies, only: :index
    resources :resident_forms

    get "/404", to: "errors#not_found"
    get '/422', to: 'errors#unprocessable_entity'
    get '/500', to: 'errors#internal_server_error'
  end
end
