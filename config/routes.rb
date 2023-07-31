Rails.application.routes.draw do
  resources :projects do
    resources :requests
    resources :checkpoints do
      resources :tasks
    end
  end
  resources :latest_news
  resources :fields
  resources :reports
  devise_for :users
  resource :profile, only: [:show, :edit, :update]

  root to: 'pages#home'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
