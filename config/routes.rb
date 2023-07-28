Rails.application.routes.draw do
  resources :progettos
  resources :utentes
  resources :requests
  resources :latest_news
  root to: 'pages#home'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  Rails.application.routes.draw do
    resources :movies
  end
end
