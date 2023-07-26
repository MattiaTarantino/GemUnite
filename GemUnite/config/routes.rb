Rails.application.routes.draw do
  resources :progettos
  devise_for :admin_users, ActiveAdmin::Devise.config
  root :to => redirect('/progettos')
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  Rails.application.routes.draw do
    resources :movies
  end
end