module EnvHelper

	def current_env
		@current_env ||= request.env
	end

	def rack_errors
		@rack_errors ||= current_env["rack.errors"]
	end

	def current_request_path
		@current_request_path = current_env["REQUEST_PATH"]
	end

	def current_path
		@current_path ||= current_env["PATH_INFO"]
	end

	def current_request_method
		@current_request_method || current_env["REQUEST_METHOD"]
	end

	def current_route_set
		@current_route_set || Rails.application.routes
	end

	def current_action_hash
		@current_action_hash ||= current_route_set.recognize_path(current_path)
	end

	def current_action_string
		@current_action_string ||= "#{current_action_hash[:controller]}##{current_action_hash[:action]}"
	end

end