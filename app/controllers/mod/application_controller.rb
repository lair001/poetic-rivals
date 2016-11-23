class Mod::ApplicationController < ApplicationController

	before_action :only_moderators_and_superusers_allowed

protected

	def only_moderators_and_superusers_allowed
		raise Pundit::NotAuthorizedError if !current_user.moderator? && !current_user.superuser?
	end

end