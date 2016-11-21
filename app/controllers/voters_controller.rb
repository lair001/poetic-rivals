class VotersController < ApplicationController

	def create
		authorize :poem_voter
		@poem_voter = PoemVoter.new(poem_id: voters_params[:poem_id], voter_id: current_user.id)
		if @poem_voter.save
			redirect_to previous_path_or_root
		else
			convert_model_errors_to_flash_error(@poem_voter)
			redirect_to previous_path_or_root
		end
	end

	def destroy
		@poem_voter = PoemVoter.find_by(voters_params)
		authorize @poem_voter
		@poem_voter.destroy
		redirect_to previous_path_or_root
	end

private

	def voters_params
		params.permit(:poem_id, :voter_id)
	end

end