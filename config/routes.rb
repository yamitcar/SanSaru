Rails.application.routes.draw do
  get 'users/new'

  get 'static_pages/home'
  get 'static_pages/help'
  get  '/signup',  to: 'users#new'

  resources :profiles
  resources :agile_relations
  resources :agiles
  resources :genders
  resources :sizes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
