class ApplicationController < ActionController::Base

	include Pundit

	protect_from_forgery with: :exception
	before_action :authorize_access
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def after_sign_in_path_for(resource)
	  request.env['omniauth.origin'] || root_path
	end

protected

	include ApplicationHelper

	def authorize_access
		if !['visitor', 'sessions', 'registrations', 'passwords', 'confirmations', 'unlocks'].include?(controller_name)
			if !user_signed_in? || current_user.banned?
				flash[:error] = "You are not authorized to access this app."
				redirect_to root_path
			end
		end
	end

	def user_not_authorized
	  flash[:error] = "Unauthorized action."
	  redirect_to(previous_path_or_root)
	end

end
