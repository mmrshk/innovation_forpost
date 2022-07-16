Rails.application.routes.draw do
  mount Lit::Engine => '/lit'
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, :controllers => {
        registrations: 'registrations'
    }
    
    root to: "home#index"
  end
end
