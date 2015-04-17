Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks',
                                        :registrations => 'registrations'  }
  resources :users, only: [:index, :show ]
  resources :problems do
    resources :attempts, only: [:index, :create, :new, :show ]
  end
end
