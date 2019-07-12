class UserStatsController < ApplicationController
	include Rails.application.routes.url_helpers
	before_action :authenticate_user!
	def stats 
		@stats = current_user.stats
		respond_to do |format|
			format.json {render json: @stats, status: :ok }
			format.pdf do
				pdf = Prawn::Document.new
				pdf.text "User Statistics", size: 30
				pdf.text "Basic Information", size: 20
				basic_info = pdf.make_table([
					["Handle:", current_user.handle],
					["Email:", current_user.email],
					["Birthday:",current_user.birthday],
					["Password:", "just kiddin' (unless you suck at setting up passwords!)"]
				], cell_style: {borders: []})
				image = (current_user.avatar.attached?)? rails_blob_url(current_user.avatar) : "app/assets/default_profile_img.jpg"
				pdf.table([
					[basic_info, {image: image, fit: [130, 130], position: :center}]
					], 
					column_widths: {0=>590, 1 => 150}, 
					cell_style: {borders: []}
				)
				pdf.pad(20){pdf.text "General Stats", size: 20}
				theme = {
					:colors => ['#FDD84E','#6886B4','#72AE6E','#D1695E','#8A6EAF', '#EFAA43','gray'],
					:marker_color => 'gray',
					:font_color => 'black',
					:background_colors => 'white'
				}
				g = Gruff::Bar.new('700x300')
				g.theme = theme
				@stats[:general_stats].each{|k,v| g.data(k, v)}
				g.show_labels_for_bar_values = true
				g.legend_font_size = 18
				g.label_formatting = '%.0f'
				pdf.image StringIO.new(g.to_blob), scale: 0.55, position: :center
				
				pdf.text "Reactions", size: 20
				g = Gruff::Pie.new(700)
				g.theme = theme
				if @stats[:general_stats][:reactions_count] > 0
					@stats[:reactions_stats].each{|k,v| g.data(k, v) } 
				end
				g.legend_font_size = 18
				g.no_data_message = "You're boring!"
				pdf.image StringIO.new(g.to_blob), scale: 0.55, position: :center
				if @stats[:general_stats][:reactions_count] > 100
					text = "If I were given a coin for each reaction you've made, I'll be poor (but not that poor!)"
				else
					text = "If I were given a coin for each reaction you've made, I'll surely be poor"
				end
				pdf.text text, size: 10
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
