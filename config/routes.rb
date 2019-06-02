Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, 
                defaults: { format: :json }, 
                path: '',
                path_names: 
                  { sign_in: 'login', 
                    sign_out: 'logout', 
                    registration: 'signup'}

    resources :users, only: [:index, :show, :update]

    concern :commentable do
    	resources :comments, only: [:index, :show]
    end

    concern :imageable do
      resources :pictures
    end

    resources :users, concerns: :imageable, except: [:show, :update] do
    	resources :posts, :memes, :reactions, :comments
    end

    resources :memes, concerns: [:imageable, :commentable] do
      resources :reactions, only: [:index, :show]
    	resources :post_memes
    end

    resources :posts, only: :show,concerns: :commentable do
    	resources :post_memes
    end

    resources :post_memes

    resources :comments, only: [:show, :update, :destroy]
    resources :pictures, :templates
 
end
