Rails.application.routes.draw do
  devise_scope :person do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_person_registration" # custom path to sign_up/registration
  end
  devise_for :people, :skip => [:registrations]
  as :person do
    get 'people/edit' => 'devise/registrations#edit', :as => 'edit_person_registration'
    put 'people/' => 'devise/registrations#update', :as => 'person_registration'
  end
  resources :documents do
    get 'my_documents', to: 'documents#my_documents', on: :member
  end
  resources :authors
  resources :enrollments
  resources :categories
  resources :people
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
