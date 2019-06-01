class ApplicationController < ActionController::API
	include ActionController::MimeResponds
	respond_to :json
	
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user

	private

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:handle, :birthday])
		end
		
		def authenticate_user
			if request.headers['Authorization'].present?
				authenticate_or_request_with_http_token do |token|
					begin
						jwt_payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
	
						@current_user_id = jwt_payload['id']
					rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
						head :unauthorized
					end
				end
			end
		end

		def authenticate_user!(options = {})
			head :unauthorized unless signed_in?
		end

		def current_user
			#Debug
			# puts("###################################")
			# for i in 0..20
			# 	puts(caller[i])
			# end
			#puts(caller)
			@current_user ||= super || User.find(@current_user_id)
		end

		def signed_in?
			@current_user_id.present?
		end
end
