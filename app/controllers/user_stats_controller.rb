class UserStatsController < ApplicationController
	before_action :authenticate_user!
	def stats
		@stats = current_user.stats
		respond_to do |format|
			format.json {render json: @stats, status: :ok }
			format.pdf do
				pdf = Prawn::Document.new
				pdf.text "User Statistics", size: 30
				pdf.text "Basic Information", size: 20
				pdf.text "Handle: #{current_user.handle}"
				pdf.text "Email: #{current_user.email}"
				pdf.text "Birthday: #{current_user.birthday}"
				pdf.text "Password: just kidding! (unless your password is actually that, in that case you suck at setting up passwords)"
				pdf.text "Your Me-me History!", size: 20
				reaction_count = @stats[:reaction_count].values.inject(0,:+)
				
				g = Gruff::Bar.new(400)
				g.labels = { 0 => 'comments', 1 => 'own_memes', 2 => 'own_posts', 3 => 'reactions'}
				g.data :values, [@stats[:comments_count], @stats[:memes_count], @stats[:posts_count], reaction_count ]
				pdf.image StringIO.new(g.to_blob)
				if reaction_count > 100
					pdf.text "If I were given a coin for each reaction you've made, I'll be poor (but not that poor!)", size: 20
				else
					pdf.text "If I were given a coin for each reaction you've made, I'll surely be poor", size: 20
				end
				pdf.text "Up #{@stats[:reaction_count][:swipe_up]}"
				pdf.text "Down #{@stats[:reaction_count][:swipe_down]}"
				pdf.text "Left #{@stats[:reaction_count][:swipe_left]}"
				pdf.text "Right #{@stats[:reaction_count][:swipe_right]}"
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
