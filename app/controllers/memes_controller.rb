class MemesController < ApplicationController
    def index
        #shouldn't be necessary due to shallow paths
        if params[:user_id]
            user = User.find(params[:user_id])
            memes = user.memes.all
        elsif user_signed_in?
            user = User.find(params[:user_id])
            memes = user.memes.
        else
            memes = Meme.all
        end
        render json: memes, status: :ok
    end
    
    def show
        user = (params[:user_id])? User.find(params[:user_id])
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
        meme = user.memes.create(meme_params)
        if meme.valid?
            render json: meme, status: :created
        else
            render json: meme.errors, status: :unprocessable_entity
        end
    end
    
    def update
        user = User.find(params[:user_id])
        meme = user.memes.find(params[:id])
        meme.image.purge_later if meme.image.attached?
        if meme.update(meme_params)
            render json: meme, status: :ok
        else
            render json: meme.errors, status: :unprocessable_entity
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
