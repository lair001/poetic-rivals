module ConcernsHelper
	module JsonHelper

		def render_record_not_found_json
			render json: { errors: [{ status: 404, title: "Record Not Found" }] }.to_json, status: 404
		end

	end
end