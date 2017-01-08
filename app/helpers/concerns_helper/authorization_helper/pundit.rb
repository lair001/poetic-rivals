module ConcernsHelper
	module AuthorizationHelper
		module Pundit

			def unauthorized_action_message
				unauthorized_access_or_action_message
			end

			def unauthorized_access_or_action_message
				"Unauthorized access or action."
			end

			def user_not_authorized
				respond_to do |f|
					f.html do
						flash[:error] = unauthorized_access_or_action_message
						redirect_to(root_path)
					end
					f.json do
						render_unauthorized_access_or_action_json
					end
				end
			end

		end
	end
end