class AuthController < ApplicationController
	def facebook
		facebook_data = HTTParty.get("https://graph.facebook.com/me",
			query:{
				access_token: params[:oauth_token],
				fields: 'email,birthday'}).parsed_response

		facebook_data["provider"]="facebook"
		facebook_data["birthday"] = Date.strptime(facebook_data["birthday"], '%m/%d/%Y').strftime('%Y-%m-%d')
		puts('############')
		p(facebook_data)
		user = User.find_for_oauth(facebook_data)
		if user.persisted?
			sign_in(user, scope: :user)
      render json: {status: 'user sucessfully created'}, status: :ok
		else
			session["devise.facebook_data"] = facebook_data
      redirect_to new_user_registration_url
		end
	end


	def google
		google_data = HTTParty.get("https://www.googleapis.com/oauth2/v2/userinfo",
			query:{
				access_token: params[:oauth_token]
				}).parsed_response
		
		google_data["provider"]="google"
		google_data["birthday"]="1998-02-02" #fake birthday, needs fixing
		user = User.find_for_oauth(google_data)
		if user.persisted?
			sign_in(user, scope: :user)
      render json: {status: 'user sucessfully created'}, status: :ok
		else
			session["devise.facebook_data"] = facebook_data
      redirect_to new_user_registration_url
		end
	end
	private
	def auth_params
			params.require(:oauth_token)
	end
end
