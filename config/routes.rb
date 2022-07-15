Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations'
  }

  root to: "home#index"
  
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable_entity'
  get '/500', to: 'errors#internal_server_error'

end
