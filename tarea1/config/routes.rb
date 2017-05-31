Rails.application.routes.draw do
  resources :authors
  resources :enrollments
  devise_for :people
  resources :documents do
    get 'my_documents', to: 'documents#my_documents', on: :member
  end
  resources :categories
  resources :people
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
