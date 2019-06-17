class CommentsController < ApplicationController
	before_action :load_commentable
	before_action :authenticate_user!, only: [:create, :update, :destroy]

	def index
		comments = @commentable.comments.all
		render json: comments, status: :ok
	end 

	def show #this is useless, do not works
		comment = @commentable.comments.find(params[:id])
		render json: comment, status: :ok
	end

	def create
		comment = @commentable.comments.new(comment_params)
		comment.user_id = current_user.id
		comment.save
		if comment.valid?
			render json: comment, status: :created
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end

	
	def update
		comment = @commentable.comments.find(params[:id])
		if comment.user_id == current_user.id
			if comment.update(comment_params)
				render json: comment, status: :ok
			else
				render json: comment.errors, status: :unprocessable_entity
			end
		else
			render json: { error: "can't find commentable for the given user"}, status: :not_found
		end
		
	end
	
	def destroy
		comment = @commentable.comments.find(params[:id])
		if comment.user_id == current_user.id
			comment.destroy
			if comment.destroyed?
				render json: comment, status: :ok
			else
				render json: comment.errors, status: :unprocessable_entity
			end
		else
			render json: { error: "can't find commentable for the given user"}, status: :not_found
		end
	end

	private 
	def load_commentable
		resource, id = request.path.split('/')[1,2]
		@commentable = resource.singularize.classify.constantize.find(id)
	end

	def comment_params
		params.require(:comment).permit(:body)
	end

end
