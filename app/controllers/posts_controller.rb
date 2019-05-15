class PostsController < ApplicationController
    
    #shallow blah blah
    def index
        if params[:id_user]
            user = User.find(params[:id_user])
            posts = user.post.all
        else
            posts = Post.all
        end
        render json: posts, status: :ok
    end
    
    def show
        user = User.find(params[:id_user])
        post = user.find(params[:id])
        render json: post, state: :ok
    end
    
    def create
        user = User.find(params[:id_user])
        post = user.create(post_params)
        if post
            render json: post, status: :created
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:id_user])
        post = user.posts.find(params[:id])
        post.update(post_params)
        if post.update(post_params)
            render json: post, status: :ok
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        user = User.find(params[:id_user])
        post = user.posts.find(params[:id])
        post.destroy()
        if post.destroyed?
            render plain: "Post destroyed", status: :ok
        else
            render post.errors, status: :unprocessable_entity
        end    
    end

    private
        def post_params
            params.require(:post).permit(:text)
        end
end
