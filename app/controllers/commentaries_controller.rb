class CommentariesController < ApplicationController

	def index
		@poem = Poem.find(params[:poem_id])
		authorize(@poem, :show?)
		render layout: 'application', locals: { model: @poem }
	end

end
