class GoogleController < ApplicationController

    def callback
        token = callback_params[:token]
        response = HTTP.post('https://www.googleapis.com/oauth2/v2/tokeninfo', :params => {:id_token => token })
        hash = JSON.parse response.body.to_s
        User.from_oauth({ :email => hash['email'], :uid => hash['user_id'], :provider => hash['issuer'] })
    end

    private 
    
        def callback_params
            params.require(:google).permit(:token)
        end

    

end
