module AuthorizationHelper
	module Pundit

		def unauthorized_action_message
			unauthorized_access_or_action_message
		end

		def unauthorized_access_or_action_message
			"Unauthorized access or action."
		end

		def user_not_authorized
		  flash[:error] = unauthorized_access_or_action_message
		  redirect_to(root_path)
		end

	end
end