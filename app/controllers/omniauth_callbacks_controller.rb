class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in @user, event: :authentication # devise-jwt will dispatch jwt
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"] # to-do
          redirect_to new_user_registration_url
        end
      end
  
      def failure 
        render json: unprocessable_entity
      end

    }
  end

  [ :facebook, :google_oauth2 ].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
