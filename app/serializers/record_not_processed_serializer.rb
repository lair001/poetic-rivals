class RecordNotProcessedSerializer < ActiveModel::Serializer::ErrorSerializer

	attributes :errors

	def errors
		[{ status: 422, title: "Record not processed.", detail: view_context.model_error_messages_as_html(object) }]
	end

	# def status
	# 	"422"
	# end

	# def title
	# 	"Record not processed."
	# end

end