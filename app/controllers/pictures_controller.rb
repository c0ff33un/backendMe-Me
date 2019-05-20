class PicturesController < ApplicationController
    before_action :load_imageable

    def index
        puts @imageable.class
		if @imageable
            images = @imageable.picture
		else
			images = Picture.all
		end
		render json: images, status: :ok
	end 

	def show
		image = Picture.find(params[:id])
		render json: image, status: :ok
	end

	def create
		image = @imageable.picture.create(image_params)
		if image
			render json: image, status: :created
		else
			render json: image.errors, status: :unprocessable_entity
		end
	end

	
	def update
		image = @imageable.picture.find(params[:id])
		if image.update(image_params)
			render json: image, status: :ok
		else
			render json: image.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		image = @imageable.picture.find(params[:id])
        image.destroy
	end

	private 
	def load_imageable
		resource, id = request.path.split('/')[1,2]
		if resource == "pictures"
			@imageable = nil
		else
			@imageable = resource.singularize.classify.constantize.find(id)
		end
	end

	def image_params
		params.require(:picture).permit(:image)
	end
end
