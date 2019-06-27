class MemesController < ApplicationController
	before_action :authenticate_user!, only:[:create, :update, :destroy, :comment]
	def index
		user = (params[:user_id])? User.find(params[:user_id]) : (user_signed_in?)? current_user : nil
		if user
			memes = user.memes.all
			render json: memes, status: :ok
		else
			render json: { error: "invalid user or not loged in"}, status: :not_found
		end
	end

	def show
		user = (params[:user_id])? User.find(params[:user_id]) : (user_signed_in?)? current_user : nil
		if user
			meme = user.memes.find(params[:id])
			render json: meme, status: :ok, rule: :show_comments
		else
			render json: { error: "invalid user or not loged in"}, status: :not_found
		end
	end

	def create
		meme = current_user.memes.create(meme_params)
		if meme.valid?
			render json: meme, status: :created
		else
			render json: meme.errors, status: :unprocessable_entity
		end
	end

	def update
		# Not necessary to verify user.
		# If that meme is not related with the logged user it will throw an error.
		meme = current_user.memes.find(params[:id])
		meme.image.purge_later if meme.image.attached?
		if meme.update(meme_params)
			render json: meme, status: :ok
		else
			render json: meme.errors, status: :unprocessable_entity
		end
	end

	def destroy 
		meme = current_user.memes.find(params[:id])
		meme.destroy
		if meme.destroyed?
			render json: meme, status: :ok
		else
			render json: meme.errors, status: :unprocessable_entity
		end
	end
	
	private

		def meme_params
			params.require(:meme).permit(:image)
		end
			
end
