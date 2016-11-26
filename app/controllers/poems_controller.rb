class PoemsController < ApplicationController

	def index
		if params.has_key?(:user_id)
			@user = User.find(params[:user_id])
			@poems = policy_scope(@user.poems)
		else
			@poems = policy_scope(Poem.all)
		end
	end

	def show
		@poem = Poem.find(params[:id])
	end

end
