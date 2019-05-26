class CommentsController < ApplicationController

	before_action :load_commentable

	def index
		comments = @commentable.comments
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
		if @commentable
			comment = @commentable.comments.find(params[:id])
		else 
			comment = Comment.find(params[:id])
		end
		
		if comment.update(comment_params)
			render json: comment, status: :ok
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		if @commentable
			comment = @commentable.coments.find(params[:id])
		else
			comment = Comment.find(params[:id])
		end
		
		comment.destroy
		if comment.destroyed?
            render json: comment, status: :ok
        else
            render json: comment.errors, status: :unprocessable_entity
		end
	end

	private 
	def load_commentable
		resource, id = request.path.split('/')[1,2]
		@commentable = resource.singularize.classify.constantize.find(id)
	end

	def comment_params
		params.require(:comment).permit(:user_id, :body)
	end

end
