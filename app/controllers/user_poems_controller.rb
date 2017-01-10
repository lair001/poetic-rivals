class UserPoemsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@poems = policy_scope(@user.poems.order(updated_at: :desc))
		render 'poems/index', layout: 'application', locals: { model: @user }
	end

end