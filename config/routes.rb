Rails.application.routes.draw do
  resources :profiles
  resources :agile_relations
  resources :agiles
  resources :genders
  resources :sizes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'profiles#index'
end
