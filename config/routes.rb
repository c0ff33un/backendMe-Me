Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  concern :commentable do
  	resources :comments
  end
  
  concern :reactionable do
  	resources :reactions
  end
  
  resources :users, concerns: [:commentable, :reactionable] do
  	resources :posts, :memes
  end
  
  resources :memes, concerns: :reactionable do
  	resources :post_memes
  end

  resources :posts, concerns: :commentable do
  	resources :post_memes
  end

  resources :post_memes, concerns: :commentable
  
  resources :comments, :reactions

end