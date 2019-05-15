class PostMemesController < ApplicationController

	def index
		post_memes = PostMeme.all
		render json: post_memes, status: :ok
	end 

	def show
		post_meme = PostMeme.find(params[:id])
		render json: post_meme, status: :ok
	end

	#should only be created through post 
	#meme should already be created
	def create
		post = Post.find(params[:id_post])
		post_meme = post.post_memes.create(post_meme_params)
		if(post_meme)
			render json: post_meme, status: :ok
		else
			render json: post_meme.errors, status: :unprocessable_entity
		end
	end

	def update
		post = Post.find(params[:id_post])
		post_meme = post.find(params[:id])
		if post_meme.update(post_meme_params)
			render json: post_meme, status: :ok
		else
			render json: post_meme.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		post = Post.find(params[:id_post])
		post_meme = post.find(params[:id])
		post_meme.destroy
	end

	private 

		def post_meme_params
			params.require(:post_meme).permit(:meme, :body)
		end
	
	

end
