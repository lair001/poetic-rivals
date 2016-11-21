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

end
