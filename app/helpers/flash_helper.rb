module FlashHelper

	def convert_model_errors_to_flash_error(model)
		flash[:error] = model_error_messages_as_html(model)
	end

end