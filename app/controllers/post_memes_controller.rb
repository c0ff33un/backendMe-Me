class PostMemesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy]
	def index
		post_memes = PostMeme.all
		render json: post_memes, status: :ok
	end 

	def show
		post_meme = PostMeme.find(params[:id])
		render json: post_meme, status: :ok
	end

	#should only be created through post 
	#meme and post should already be created
	def create
		post = current_user.posts.find(params[:post_id])
		post_meme = post.post_memes.create(post_meme_params[:memes])
		render json: post_meme, status: :ok
	end

	def update
		post = current_user.posts.find(params[:post_id])
		post_meme = post.post_memes.find(params[:id])
		if post_meme.update(post_meme_params[:memes])
			render json: post_meme, status: :ok
		else
			render json: post_meme.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		post = current_user.posts.find(params[:post_id])
		post_meme = post.post_memes.find(params[:id])
		post_meme.destroy
		if post_meme.destroyed?
			render json: post_meme, status: :ok
		else
			render json: post_meme.errors, status: :unprocessable_entity
		end
	end
	private 

		def post_meme_params
			params.require(:post_meme).permit(memes:[:meme_id, :body])
		end
	
	

end
