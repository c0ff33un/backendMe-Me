class ReactionsController < ApplicationController


	before_action :load_reaction

	def index
		reactions = @reactionable.reactions.all
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
		if reaction.valid?
			render json: reaction, status: :created
		else
			render json: reaction.errors, status: :unprocessable_entity
		end
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
		if reaction.destroyed?
            render json: reaction, status: :ok
        else
            render json: reaction.errors, status: :unprocessable_entity
		end
	end

	private
		def load_reaction
			resource, id = request.path.split('/')[1,2]
			@reactionable = resource.singularize.classify.constantize.find(id)
		end
			
		def reaction_params
			params.require(:reaction).permit(:meme_id, :reaction_type)
		end

end
