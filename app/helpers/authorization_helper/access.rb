module AuthorizationHelper
	module Access

		def unauthorized_access_message
			unauthorized_access_or_action_message
		end

		def authorize_access
			if !['visitor', 'sessions', 'registrations', 'passwords', 'confirmations', 'unlocks', 'omniauth_callbacks'].include?(controller_name)
				if !user_signed_in? || current_user.banned?
					authorize :access, :app?
				end
			end
		end

	end
end