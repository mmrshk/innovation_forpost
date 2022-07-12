# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'file_uploads/upload'
  # mount NewCkeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :attachments
    # resources :articles
    resources :articles, except: %i[show] do
      collection do
        post :upload
        # post :classic
      end
    end
  end
  # devise said he wants to have a specified root rout, so:
  root to: 'home#index'
  resources :articles, only: %i[index show]
  resources :tags
end
