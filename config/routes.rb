Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations', sessions: 'sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'static_pages/home'
  get '/terms', to: 'static_pages#terms'
  get '/privacidad', to: 'static_pages#privacidad'
  resources :profiles, except: %i[edit new create update show destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/home', to: 'home#show'
  get '/home/edit', to: 'home#edit'
  get '/home/new', to: 'home#new'
  post '/home', to: 'home#create'
  patch '/home', to: 'home#update'
  put '/home/:id', to: 'home#update'
  post '/home/uninvite/:invited', to: 'home#uninvite'
  post '/home/invite/:invited', to: 'home#invite'
  get 'graph/:event_home', to: 'graph#index'
  get 'graph/data/:event_home', to: 'graph#data', defaults: { format: 'json' }
  post '/favorite/add', to: 'favorite#add_favorite'
  post '/favorite/remove', to: 'favorite#remove_favorite'
  get '/favorite', to: 'profiles#favorites'

  get 'cities/:country', to: 'divipola#states'
  get 'cities/:country/:state', to: 'divipola#cities'

  resources :events
  resources :pages
  resources :custom_emails

  get '/:event_id/:page_path', to: 'static_pages#prepare_render'
  get '/event/select/:event_id', to: 'events#change_event'
  get '/event/download/:event_id', to: 'events#get_participants'

end
