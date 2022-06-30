Rails.application.routes.draw do
  mount Lit::Engine => '/lit'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise said he wants to have a specified root rout, so:
  root to: "home#index"
end
