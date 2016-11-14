module Users

	module OmniauthCallbacksHelper

		def omniauth_authentication
			@user = User.from_omniauth(request.env["omniauth.auth"])
		    if @user
		      sign_in_and_redirect(@user)
		    else
		      redirect_to new_user_registration_path
		    end
		end

	end

end