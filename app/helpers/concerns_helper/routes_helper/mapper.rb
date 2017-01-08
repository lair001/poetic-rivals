module ConcernsHelper
	module RoutesHelper
		module Mapper

			def generate_routes_string
				all_routes = Rails.application.routes.routes
				inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
				inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, nil).sub(/^[^\n]+\n/, "")
			end

			def routes_string
				@routes_string ||= generate_routes_string
			end

			def routes_array
				@routes_array ||= generate_routes_array
			end

			def generate_routes_array
				routes_row_array = routes_string.split("\n")
				routes_row_array.collect { |row| row.split("\s")  }
			end

			def generate_path_method_path_name_hash
				path_method_path_name_hash = {}
				routes_array.each do |route|
					path = route[2].gsub("(.:format)", "") if route[2].is_a?(String)
					path_method_path_name_hash[path] = {} if !path_method_path_name_hash.has_key?(path)
					route[1].split("|").each { |method| path_method_path_name_hash[path][method] = route[0] } if route[1].is_a?(String)
				end
				path_method_path_name_hash
			end

			def path_method_path_name_hash
				@path_method_path_name_hash ||= generate_path_method_path_name_hash
			end

		end
	end
end