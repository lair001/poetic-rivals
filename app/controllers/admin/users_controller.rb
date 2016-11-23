class Admin::UsersController < Admin::ApplicationController

	def edit
		@user = User.find(params[:id])
		render 'devise/registrations/edit', layout: 'application', locals: { model: @user }
		# render 'devise/registrations/edit'
	end

	def update
		@user = User.find(params[:id])
		raise Pundit::NotAuthorizedError unless current_user.valid_password?(params[:user][:admin_password])
		remove_empty_keys_from(params[:user])
		if @user.update(admin_user_params)
			redirect_to previous_path_or_root
		else
			@current_path_name = "edit_admin_user" # need to manually set this for the title block to display
			render 'devise/registrations/edit', layout: 'application', locals: { model: @user }
		end
	end

private

	def admin_user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

end