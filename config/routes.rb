Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, 
              defaults: { format: :json }, 
              path: '',
              path_names: 
                { sign_in: 'login', 
                  sign_out: 'logout', 
                  registration: 'signup'}
  
  
  #----- "public" routes -----
  concern :commentable do
  	resources :comments, only: :index
  end

  concern :user_accesible do
    resources :memes, :posts, only: :index
  end

  #only allows access users by id or if returns loged user
  resources :users, only: :show, concerns: :user_accesible
  resource :user, only: :show do
    resources :memes, :posts
    member do
      get 'activity', to: 'activity#index' #shows all activities
      #shows activities per type
      get 'activity/comments', to: 'comments#index'
      get 'activity/up'
      get 'activity/down'
      get 'activity/right'
      get 'activity/left'
    end
  end
  resolve('user'){[:user]}
  
  # resources :memes, :posts, concerns: :commentable, only: [:index, :show] do
  #   collection do
  #     get 'best'
  #     get 'hot'
  #     get 'newest'
  #   end
  # end

  
  #resource :posts, only: [:index, :show]
  #----- old routes -----
  
  # resources :users, only: [:index, :show, :update]
  
  # namespace :feed do
  #   get 'best'
  #   get 'hot' 
  #   get 'newest'
  # end

  # namespace :momazos do
  #   get 'best'
  #   get 'hot'
  #   get 'newest'
  # end

  # namespace :user_stats do
  #   get 'stats'
  #   get 'best_memes'
  #   get 'best_posts'
  # end

  # concern :commentable do
  # 	resources :comments, only: [:index, :show]
  # end

  # resources :users, except: [:show, :update] do
  # 	resources :posts, :memes, :reactions, :comments
  # end

  # resources :memes, concerns: :commentable do
  #   resources :reactions, only: [:index, :show]
  # 	resources :post_memes
  # end

  # resources :posts, only: :show,concerns: :commentable do
  # 	resources :post_memes
  # end

  # resources :post_memes

  # resources :comments, only: [:show, :update, :destroy]
  # resources :templates
 
end
