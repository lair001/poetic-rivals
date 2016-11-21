class RivalsController < ApplicationController

	def create
		authorize :rival_victim
		@rival_victim = RivalVictim.new(victim_id: rivals_params[:victim_id], rival_id: current_user.id)
		if @rival_victim.save
			redirect_to previous_path_or_root
		else
			convert_model_errors_to_flash_error(@rival_victim)
			redirect_to previous_path_or_root
		end
	end

	def destroy
		@rival_victim = RivalVictim.find_by(rivals_params)
		authorize @rival_victim
		@rival_victim.destroy
		redirect_to previous_path_or_root
	end

private

	def rivals_params
		params.permit(:victim_id, :rival_id)
	end

end