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
		user = (params[:user_id])? User.find(params[:user_id]) : (user_signed_in?)? current_user : nil
		if user
				post = user.posts.find(params[:id])
				render json: post, state: :ok
		else
			render json: { error: "invalid user or not loged in"}, status: :not_found
		end
	end
	
	def create
		user = current_user
		post = user.posts.create(post_params)
		if post.valid?
			render json: post, status: :created
		else
			render json: post.errors, status: :unprocessable_entity
		end
	end

	def update
		user = current_user
		post = user.posts.find(params[:id])
		if post.update(post_params)
			render json: post, status: :ok
		else
			render json: post.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		user = current_user
		post = user.posts.find(params[:id])
		post.destroy()
		if post.destroyed?
			render json: post, status: :ok
		else
			render json: post.errors, status: :unprocessable_entity
		end    
	end

	private
		def post_params
			params.require(:post).permit(:body)
		end
end
