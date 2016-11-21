class AdminController < ApplicationController

	before_action :only_administrators_and_superusers_allowed

protected

	def only_administrators_and_superusers_allowed
		raise Pundit::NotAuthorizedError if !current_user.administrator? && !current_user.superuser?
	end

end