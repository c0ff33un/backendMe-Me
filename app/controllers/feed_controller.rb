class FeedController < ApplicationController

    before_action :load_defaults

    def best
        render json: Post.best.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    def hot
        render json: Post.hot.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    def newest
        render json: Post.newest.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    
    private

        def feed_params
            params.permit(:page, :per_page)
        end

        def load_defaults
            params[:page] = 1 if params[:page] == nil 
            params[:per_page] = 12 if params[:per_page] == nil
        end

end
