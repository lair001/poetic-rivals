class ApplicationController < ActionController::Base

	include Pundit

	protect_from_forgery with: :exception
	before_action :authorize_access
	after_action :store_http_referer_in_session_for_next_action
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def after_sign_in_path_for(resource)
	  request.env['omniauth.origin'] || root_path
	end

protected

	include ApplicationHelper

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
