class UserStatsController < ApplicationController
	include Rails.application.routes.url_helpers
	before_action :authenticate_user!
	def stats 
		@stats = current_user.stats
		respond_to do |format|
			format.json {render json: @stats, status: :ok }
			format.pdf do
				pdf =  UserStatsPdf.new(current_user, @stats)
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
