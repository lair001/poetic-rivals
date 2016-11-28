class PoemsController < ApplicationController

	def index
		if params.has_key?(:user_id)
			@user = User.find(params[:user_id])
			@poems = policy_scope(@user.poems.order(updated_at: :desc))
			render layout: 'application', locals: { model: @user }
		elsif params.has_key?(:genre_id)
			@genre = Genre.find(params[:genre_id])
			sort_genre_poems_by_updated_at
			render layout: 'application', locals: { model: @genre }
		else
			@poems = policy_scope(Poem.all)
		end
	end

	def show
		@poem = Poem.find(params[:id])
		authorize(@poem)
		render layout: 'application', locals: { model: @poem }
	end

end
