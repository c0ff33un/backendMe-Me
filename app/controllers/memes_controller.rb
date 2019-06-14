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
			render json: meme, status: :ok
		else
			render json: { error: "invalid user or not loged in"}, status: :not_found
		end
	end

	def create
		user = current_user
		meme = user.memes.create(meme_params)
		if meme.valid?
			render json: meme, status: :created
		else
			render json: meme.errors, status: :unprocessable_entity
		end
	end

	def update
		user = current_user
		meme = user.memes.find(params[:id])
		meme.image.purge_later if meme.image.attached?
		if meme.update(meme_params)
			render json: meme, status: :ok
		else
			render json: meme.errors, status: :unprocessable_entity
		end
	end

	def destroy
		user = current_user
		meme = user.memes.find(params[:id])
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
