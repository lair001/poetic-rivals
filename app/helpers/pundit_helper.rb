module PunditHelper

	def unauthorized_action_message
		"Unauthorized action."
	end

	def user_not_authorized
	  flash[:error] = unauthorized_action_message
	  redirect_to(previous_path_or_root)
	end

end