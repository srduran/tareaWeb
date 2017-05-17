Rails.application.routes.draw do
  devise_for :people
  resources :documents
  resources :categories
  resources :people
  root to: 'people#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
