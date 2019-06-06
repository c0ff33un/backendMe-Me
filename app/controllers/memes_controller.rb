class MemesController < ApplicationController
    def index
        #shouldn't be necessary due to shallow paths
        if params[:user_id]
            user = User.find(params[:user_id])
            memes = user.memes.all
        else
            memes = Meme.all
        end
        render json: memes, status: :ok
    end
    
    def show
        if params[:user_id]
            user = User.find(params[:user_id])
            meme = user.memes.find(params[:id])
        else
            meme = Meme.find(params[:id])
        end
        render json: meme, status: :ok
    end
    
    def create
        user = User.find(params[:user_id])
        meme = user.memes.create(
            picture: Picture.create(
                image: meme_params[:picture_image]
            )
        )
        if meme.valid?
            render json: meme, status: :created
        else
            render json: meme.errors, status: :unprocessable_entity
        end
    end
    
    def update
        user = User.find(params[:user_id])
        meme = user.memes.find(params[:id])
        meme.picture.destroy

        if meme.picture.destroyed?
            valid = meme.update(
                picture: Picture.create(
                    image: meme_params[:picture_image]
                )
            )
            if valid
                render json: meme, status: :ok
            else
                render json: meme.errors, status: :unprocessable_entity
            end
        else
            render json: meme.picture.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        user = User.find(params[:user_id])
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
