module ConcernsHelper
	module ModelsHelper

		def model_error_messages_as_html(model)
			error_messages = ""
			model.errors.full_messages.each do |error|
			    error_messages += error + "<br>"
			end
			error_messages
		end

	end
end