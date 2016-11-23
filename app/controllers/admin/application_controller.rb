class Admin::ApplicationController < ApplicationController

	before_action do 
		authorize :access, :admin?
	end

protected

	def only_administrators_and_superusers_allowed
		raise Pundit::NotAuthorizedError if !current_user.administrator? && !current_user.superuser?
	end

end