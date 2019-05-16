class MemesController < ApplicationController
    
    def user_param
        params[:user_id]
    end


    def index
        #shouldn't be necessary due to shallow paths
        if user_param
            user = User.find(params[:user_id])
            memes = user.memes.all
        else
            memes = Meme.all
        end
        render json: memes, status: :ok
    end
    
    def show
        if user_param
            user = User.find(params[:user_id])
        else
            meme = Meme.find(params[:id])
        end
        render json: meme, status: :ok
    end
    
    def create
        user = User.find(params[:user_id])
        meme = user.memes.create(meme_params)
        if meme
            render json: meme, status: :created
        else
            render json: meme.errors, status: :unprocessable_entity
        end
    end
    
    def update
        user = User.find(params[:user_id])
        meme = user.memes.find(params[:id])
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
