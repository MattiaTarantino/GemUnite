Rails.application.routes.draw do
  resources :projects
  resources :users
  resources :requests
  resources :latest_news
  resources :reports
  resources :tasks
  resources :checkpoints

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
