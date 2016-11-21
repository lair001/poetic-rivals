module AuthorizationHelper
	module Access

		def unauthorized_access_message
			"You are not authorized to access this app."
		end

		def authorize_access
			if !['visitor', 'sessions', 'registrations', 'passwords', 'confirmations', 'unlocks'].include?(controller_name)
				if !user_signed_in? || current_user.banned?
					flash[:error] = unauthorized_access_message
					redirect_to root_path
				end
			end
		end

	end
end