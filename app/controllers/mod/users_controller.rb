class Mod::UsersController < Mod::ApplicationController

	def update
		@user = User.find(params[:id])
		authorize @user, :ban?
		role = @user.banned? ? 1 : 0
		if @user.update(role: role)
			redirect_to previous_path_or_root
		else
			convert_model_errors_to_flash_error(@user)
			redirect_to previous_path_or_root
		end
	end

private

	def mod_user_params
		params.require(:user).permit(:role)
	end

end