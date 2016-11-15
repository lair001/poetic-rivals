module RoutesHelper
	module Base

		def path_names
			@path_names ||= Rails.application.routes.routes.anchored_routes.collect { |route| route.name }.compact
		end

		def paths
			@paths ||= routes_array.collect { |route| route[2] }
		end

		def current_path_name
			@current_path_name ||= path_path_name_hash[current_path]
		end

		def current_action
			@current_action ||= "#{current_action_hash[:controller]}##{current_action_hash[:action]}"
		end

		def current_route_set
			@current_route_set || Rails.application.routes
		end

		def current_request_path
			@current_request_path = current_env["REQUEST_PATH"]
		end

		def current_path
			@current_path ||= current_env["PATH_INFO"]
		end

		def current_request_method
			@current_request_method ||= current_env["REQUEST_METHOD"]
		end

		def current_action_hash
			@current_action_hash ||= current_route_set.recognize_path(current_path)
		end

	end
end