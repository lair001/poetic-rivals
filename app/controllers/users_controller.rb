class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		render layout: 'application', locals: { model: @user }
	end

end