class FansController < ApplicationController

	def create
		authorize :fan_idol
		params[:fan_id] = current_user.id
		@fan_idol = FanIdol.new(fan_params)
		if @fan_idol.save
			redirect_to previous_path_or_root
		else
			convert_model_errors_to_flash_error(@fan_idol)
			redirect_to previous_path_or_root
		end
	end

	def destroy
		@fan_idol = FanIdol.find_by(fan_params)
		authorize @fan_idol
		@fan_idol.destroy
		redirect_to previous_path_or_root
	end

private

	def fan_params
		params.permit(:idol_id, :fan_id)
	end

end