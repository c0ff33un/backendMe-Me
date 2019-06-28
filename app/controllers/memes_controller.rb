class MemesController < ApplicationController
	before_action :authenticate_user!, only:[:create, :update, :destroy, :comment]
	before_action :pagination_defaults, only: :index
	def index
		user = (params[:user_id])? User.find(params[:user_id]) : (user_signed_in?)? current_user : nil
		if user
			memes = user.memes.all
			render json: memes.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
		else
			render json: { error: "invalid user or not loged in"}, status: :not_found
		end
	end

	def show
		meme = Meme.find(params[:id])
		render json: meme, rule: :full_size, status: :ok
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

		def pagination_defaults
			params[:page] = 1 if params[:page] == nil 
			params[:per_page] = 12 if params[:per_page] == nil
		end
end
