class CommentsController < ApplicationController

	before_action :load_commentable

	def index
		if @commentable
			comments = @commentable.comments
		else
			comments = Comment.all
		end
		render json: comments, status: :ok
	end 

	def show
		comment = Comment.find(params[:id])
		render json: comment, status: :ok
	end

	def create
		comment = @commentable.comments.create(comment_params)
		if comment
			render json: comment, status: :created
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end

	
	def update
		comment = @commentable.comments.find(params[:id])
		if comment.update(comment_params)
			render json: comment, status: :ok
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		comment = @commentable.comments.find(params[:id])
		comment.destroy
	end

	private 
	def load_commentable
		resource, id = request.path.split('/')[1,2]
		if resource == "comments"
			@commentable = nil
		else
			@commentable = resource.singularize.classify.constantize.find(id)
		end
	end

	def comment_params
		params.require(:comment).permit(:body, :commentable_type)
	end

end
