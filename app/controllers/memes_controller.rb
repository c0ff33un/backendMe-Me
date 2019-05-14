class MemesController < ApplicationController
    def index
        user = User.find(params[:id_user])
        memes = user.memes.all
        render json: memes, status: :ok
    end
    def show
        user = User.find(params[:id_user])
        meme = user.memes.find(params[:id])
        render json: meme, status: :ok
    end
    def create
        user = User.find(params[:id_user])
        meme = user.memes.create(meme_params)
        if meme
            render json: meme, status: :created
        else
            render json: meme.errors, status: :unprocessable_entity
        end
    end
    def update
        user = User.find(params[:id_user])
        meme = user.memes.find(params[:id])
        meme.update(meme_params)
        if meme.update(meme_params)
            render json: meme, status: :ok
        else
            render json: meme.errors, status: :unprocessable_entity
        end
    end
    def destroy
        user = User.find(params[:id_user])
        meme = user.memes.find(params[:id])
        meme.destroy
        if meme.destroyed?
            render json: meme, status: :ok
        else
            render json: meme.errors, status: :unprocessable_entity
    end

    private
    def meme_params()
        params.require(:meme).permit(:image)
    end
end
