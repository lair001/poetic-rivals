module ConcernsHelper
	module JsonHelper

		def render_record_not_found_json
			render json: { errors: [{ status: 404, title: "Record not found." }] }.to_json, status: 404
		end

		def render_unauthorized_access_or_action_json
			render json: { errors: [{ status: 403, title: unauthorized_access_or_action_message }] }.to_json, status: 403
		end

	end
end