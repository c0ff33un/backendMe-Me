class ApplicationController < ActionController::API
	include ActionController::MimeResponds
	respond_to :json
	
	before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_signup_complete
    return if action_name == 'finish_signup'

    if current_user && !current_user.email.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

	private

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:handle, :birthday, :avatar])
		end

end
