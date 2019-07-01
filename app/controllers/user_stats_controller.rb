class UserStatsController < ApplicationController
    before_action :authenticate_user!
    def stats
        @stats = current_user.stats
        respond_to do |format|
            format.json {render json: @stats, status: :ok }
            format.pdf do
                pdf = Prawn::Document.new
                pdf.text "User Statistics", size: 30

                pdf.text "Comments:  #{@stats[:comments]}"
                pdf.text "Own memes: #{@stats[:comments]}"
                pdf.text "Own posts: #{@stats[:comments]}"
                pdf.text "Reactions: #{@stats[:comments]}"
                
                send_data pdf.render, filename: 'statistics.pdf', type: 'application/pdf'
            end
        end
    end

    def best_memes
        render json: current_user.best_memes , status: :ok   
    end

    def best_posts
        render json: current_user.best_posts , status: :ok   
    end

end
