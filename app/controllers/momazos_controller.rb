class MomazosController < ApplicationController
    before_action :pagination_defaults

    def best
        render json: Meme.best.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    def hot
        render json: Meme.hot.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    def newest
        render json: Meme.newest.paginate(page: params[:page]).per_page(params[:per_page]), status: :ok
    end

    
    private

        def feed_params
            params.permit(:page, :per_page)
        end

        def pagination_defaults
            params[:page] = 1 if params[:page] == nil 
            params[:per_page] = 12 if params[:per_page] == nil
        end

end
