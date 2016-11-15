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

		def generate_path_path_name_hash
			path_path_name_hash = {}
			routes_array.each do |route|
				path = route[2].gsub("(.:format)", "")
				path_path_name_hash[path] = route[0]
			end
			path_path_name_hash
		end

		def path_path_name_hash
			@path_path_name_hash ||= generate_path_path_name_hash
		end

	end
end