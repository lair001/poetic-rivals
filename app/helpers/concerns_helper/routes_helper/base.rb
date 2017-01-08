module ConcernsHelper
	module RoutesHelper
		module Base

			def path_names
				@path_names ||= Rails.application.routes.routes.anchored_routes.collect { |route| route.name }.compact
			end

			def paths
				@paths ||= routes_array.collect { |route| route[2] }
			end

			def current_path_with_parameter_names
				if current_path.match(/\A\/users\/(\d)+\z/)
					"/users/:id"
				elsif current_path.match(/\A\/admin\/users\/(\d)+\/edit\z/)
					"/admin/users/:id/edit"
				elsif current_path.match(/\A\/admin\/genres\/(\d)+\/edit\z/)
					"/admin/genres/:id/edit"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\z/)
					"/users/:user_id/poems"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/new\z/)
					"/users/:user_id/poems/new"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/(\d)+\z/)
					"/users/:user_id/poems/:id"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/(\d)+\/edit\z/)
					"/users/:user_id/poems/:id/edit"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/(\d)+\/commentaries\z/)
					"/users/:user_id/poems/:poem_id/commentaries"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/(\d)+\/commentaries\/new\z/)
					"/users/:user_id/poems/:poem_id/commentaries/new"
				elsif current_path.match(/\A\/users\/(\d)+\/poems\/(\d)+\/commentaries\/(\d)+\/edit\z/)
					"/users/:user_id/poems/:poem_id/commentaries/:id/edit"
				elsif current_path.match(/\A\/genres\/(\d)+(\.\w+)?\z/)
					"/genres/:id"
				elsif current_path.match(/\A\/genres\/(\d)+\/authors\z/)
					"/genres/:genre_id/authors"
				elsif current_path.match(/\A\/genres\/(\d)+\/poems\z/)
					"/genres/:genre_id/poems"
				else
					current_path
				end

			end

			def current_path_name
				@current_path_name ||= path_method_path_name_hash[current_path_with_parameter_names][current_request_method]
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
end