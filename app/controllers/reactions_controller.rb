class ReactionsController < ApplicationController
	before_action :load_reactionable
	before_action :authenticate_user!, only:[:create, :update, :destroy]

	def index
		reactions = @reactionable.reactions.all
		render json: reactions, status: :ok
	end 

	def show
		reaction = @reactionable.reactions.find(params[:id])
		render json: reaction, status: :ok
	end

	def create
		reaction = @reactionable.reactions.new(reaction_params)
		reaction.user_id = current_user.id
		reaction.save
		if reaction.valid?
			render json: reaction, status: :created
		else
			render json: reaction.errors, status: :unprocessable_entity
		end
	end

	def update
		reaction = current_user.reactions.find(params[:id])
		if reaction.update(reaction_params)
			render json: reaction, status: :ok
			RecalcultateScoresJob.perform_later reaction.meme
		else
			render json: reaction.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		reaction = current_user.reactions.find(params[:id])
		reaction.destroy
		if reaction.destroyed?
            render json: reaction, status: :ok
        else
            render json: reaction.errors, status: :unprocessable_entity
		end
	end

	private
		def load_reactionable
			resource, id = request.path.split('/')[1,2]
			@reactionable = resource.singularize.classify.constantize.find(id)
		end
			
		def reaction_params
			params.require(:reaction).permit(:reaction_type)
		end

end
