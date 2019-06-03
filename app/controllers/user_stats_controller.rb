class UserStatsController < ApplicationController

    def stats
        render json: User.find(4).stats , status: :ok   
    end

    def best_memes
        render json: User.find(4).best_memes , status: :ok   
    end

    def best_posts
        render json: User.find(4).best_posts , status: :ok   
    end

end
