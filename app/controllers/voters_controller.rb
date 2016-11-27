class VotersController < ApplicationController

	def create
		authorize :poem_voter
		params[:voter_id] = current_user.id
		@poem_voter = PoemVoter.new(voter_params)
		if @poem_voter.save
			redirect_to previous_path_or_root
		else
			convert_model_errors_to_flash_error(@poem_voter)
			redirect_to previous_path_or_root
		end
	end

	def destroy
		@poem_voter = PoemVoter.find_by(voter_params)
		authorize @poem_voter
		@poem_voter.destroy
		redirect_to previous_path_or_root
	end

private

	def voter_params
		params.permit(:poem_id, :voter_id, :value)
	end

	def nested_voter_params
		params.require(:poem_voter).permit(:poem_id, :voter_id, :value)
	end

end