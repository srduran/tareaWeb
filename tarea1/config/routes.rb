Rails.application.routes.draw do
  resources :enrollments
  devise_for :people
  resources :documents
  resources :categories
  resources :people
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
