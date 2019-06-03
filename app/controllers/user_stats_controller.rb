class UserStatsController < ApplicationController
    before_action :authenticate_user!
    def stats
        render json: current_user.stats , status: :ok   
    end

    def best_memes
        render json: current_user.best_memes , status: :ok   
    end

    def best_posts
        render json: current_user.best_posts , status: :ok   
    end

end
