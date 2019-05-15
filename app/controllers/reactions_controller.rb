class ReactionsController < ApplicationController

	def index
		reactions = Reaction.all
		render json: reactions, status: :ok
	end 

	def show
		reaction = Reaction.find(params[:id])
		render json: reaction, status: :ok
	end

	#should only be created through user
	#meme should already exist
	def create
		user = User.find(params[:user_id])
		reaction = user.reactions.create(reaction_params)
	end

	def update
		user = User.find(params[:user_id])
		reaction = user.reactions.find(params[:id])
		if reaction.update(reaction_params)
			render json: reaction, status: :ok
		else
			render json: reaction.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		user = User.find(params[:user_id])
		reaction = user.reactions.find(params[:id])
		reaction.destroy
	end

	private
		
		def reaction_params
			params.require(:reaction).permit(:meme, :reaction_type)
		end

	

end
