class PostsController < ApplicationController
	before_action :authenticate_user!, only:[:create, :update, :destroy]
	def index
		user = (params[:user_id])? User.find(params[:user_id]) : (user_signed_in?)? current_user : nil
	if user
		posts = user.posts.all
		render json: posts, status: :ok
	else
		render json: { error: "invalid user or not loged in"}, status: :not_found
	end
	end
	
	def show
		post = Post.find(params[:id])
		render json: post, rule: :memes, state: :ok
	end
	
	def create
		post = current_user.posts.create(post_params)
		if post.valid?
			render json: post, status: :created
		else
			render json: post.errors, status: :unprocessable_entity
		end
	end

	def update
		post = current_user.posts.find(params[:id])
		if post.update(post_params)
			render json: post, status: :ok
		else
			render json: post.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		post = current_user.posts.find(params[:id])
		post.destroy()
		if post.destroyed?
			render json: post, status: :ok
		else
			render json: post.errors, status: :unprocessable_entity
		end    
	end

	private
		def post_params
			params.require(:post).permit(:body, post_memes_attributes:[:id, :meme_id,:body])
		end
end
