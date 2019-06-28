class AuthController < ApplicationController
	def facebook
		facebook_data = HTTParty.get("https://graph.facebook.com/me",
			query:{
				access_token: params[:oauth_token],
				fields: 'email,birthday'}).parsed_response
		facebook_data["provider"]="facebook"
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
		google_data = HTTParty.get("https://www.googleapis.com/oauth2/v2/tokeinfo",
			query:{
				id_token: params[:oauth_token]
				}).parsed_response
		google_data["provider"]="google"
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
