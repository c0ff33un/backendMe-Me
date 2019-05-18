class PostsController < ApplicationController
    
    def index
        if params[:user_id]
            user = User.find(params[:user_id])
            posts = user.posts.all
        else
            posts = Post.all
        end
        render json: posts, status: :ok
    end
    
    def show
        # We just require post Id.
        post = Post.find(params[:id])
        render json: post, state: :ok
    end
    
    def create
        user = User.find(params[:user_id])
        post = user.posts.create(post_params)
        if post
            render json: post, status: :created
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:user_id])
        post = user.posts.find(params[:id])
        if post.update(post_params)
            render json: post, status: :ok
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        user = User.find(params[:user_id])
        post = user.posts.find(params[:id])
        post.destroy()
        if post.destroyed?
            render json: post, status: :ok
        else
            render json: post.errors, status: :unprocessable_entity
        end    
    end

    private
        def post_params
            params.require(:post).permit(:body)
        end
end
