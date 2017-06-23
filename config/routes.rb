Rails.application.routes.draw do

  devise_scope :person do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_person_registration" # custom path to sign_up/registration
  end
  get 'people/sign_up' => redirect('people/sign_in')
  get 'people/new' => redirect('people/sign_in')
  get 'authors' => redirect('documents')
  get '/documents/:document_id/suggestions/:id/comments' => redirect('/documents/document_id/suggestions/id')
  devise_for :people
  resources :documents do
    get 'my_documents', to: 'documents#my_documents', on: :member
    resources :suggestions do
      resources :comments
    end
    end
  resources :likes do
    post 'add', to: 'likes#addLike', on: :member
    get 'count', to: 'likes#getLikingPeople', on: :member
    delete 'remove', to: 'likes#removeLike', on: :member
  end
  resources :authors
  resources :enrollments
  resources :categories
  resources :people
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
