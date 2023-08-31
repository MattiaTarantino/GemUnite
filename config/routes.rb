Rails.application.routes.draw do
  resources :users, only: [] do
    resources :projects do
      get 'my_projects', on: :collection
      get 'open_github'
      get 'show_my_project'
      put 'close_requests'
      put 'close_project'
      put 'espelli_membro'
      resources :chats, only: [] do
        resources :messages, only: [:create]
      end
      resources :requests do
        put 'accept'
        put 'decline'
      end
      resources :checkpoints do
        put 'change_state'
        resources :tasks do
          put 'change_state'
        end
      end
    end

    resources :requests, only: [:my_request] do
      collection do
        get 'my_requests'
      end
    end

    resources :latest_news, only: [:index]
    resources :reports, only: [:index, :new, :create]
  end

  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' } # per collegare il controller customizzato a devise

  authenticated do
    root :to => 'projects#index', as: :authenticated # se l'utente è loggato, viene reindirizzato alla pagina dei progetti
  end
  root to: 'pages#home'

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #

end
