Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  concern :commentable do
  	resources :comments, only: [:index, :show]
  end
  
  concern :imageable do
    resources :pictures
  end
  
  resources :users, concerns: :imageable do
  	resources :posts, :memes, :reactions, :comments
  end
  
  resources :memes, concerns: :imageable do
    resources :reactions, only: [:index, :show]
  	resources :post_memes
  end

  resources :posts, only: :show,concerns: :commentable do
  	resources :post_memes
  end

  resources :post_memes, concerns: :commentable
  
  resources :comments, only: [:show, :update, :destroy]
  resources :pictures, :templates

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
