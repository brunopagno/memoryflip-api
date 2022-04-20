Rails.application.routes.draw do
  resources :users, only: %i[create update destroy]
  resource :session, only: %i[create destroy]
  resources :cards, only: %i[create update destroy]
  resources :collections, only: %i[create update destroy]

  get '/collections/:id/cards', to: 'collections#list'

  root to: 'pages#index'
end
