Rails.application.routes.draw do
  resources :users, only: %i[create update destroy]
  resource :session, only: %i[create destroy]
  resources :cards, only: %i[index create update destroy]

  root to: 'pages#index'
end
