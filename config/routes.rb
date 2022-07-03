Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :attachments
  end
  # devise said he wants to have a specified root rout, so:
  root to: "home#index"
end
