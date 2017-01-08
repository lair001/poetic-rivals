module ConcernsHelper
	module AuthorizationHelper
		module Access

			def unauthorized_access_message
				unauthorized_access_or_action_message
			end

			def authorize_access_to_app
				if !['visitor', 'sessions', 'registrations', 'passwords', 'confirmations', 'unlocks', 'omniauth_callbacks'].include?(controller_name)
					authorize :access, :app?
				end
			end

		end
	end
end