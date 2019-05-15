class CommentariesController < ApplicationController

	def index
		commentaries = Comment.all
		render json: commentaries, status: :ok
	end 

	def show
		comment = Comment.find(params[:id])
		render json: comment, status: :ok
	end

	#don't know yet how to handle create for polymorphic
	def create

	end

	#same
	def update

	end
	
	#same
	def destroy

	end

	#cry


end
