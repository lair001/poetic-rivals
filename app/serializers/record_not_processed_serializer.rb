class RecordNotProcessedSerializer < ActiveModel::Serializer::ErrorSerializer

	attributes :status, :title

	def status
		"422"
	end

	def title
		"Record not processed."
	end

end