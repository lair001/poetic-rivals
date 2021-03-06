class ApplicationController < ActionController::Base

	include Pundit

	protect_from_forgery with: :exception
	before_action :authorize_access_to_app
	after_action :store_http_referer_in_session_for_next_action
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	rescue_from(ActiveRecord::RecordNotFound) { redirect_to previous_path_or_root }

	serialization_scope :view_context

	def after_sign_in_path_for(resource)
	  request.env['omniauth.origin'] || root_path
	end

protected

	include ActionView::Helpers::UrlHelper

	include ApplicationHelper

	def remove_empty_keys_from(hash)
		if hash
			hash.each { |key, value| hash.except!(key) if value == "" }
		end
	end

end
