class CommentariesController < ApplicationController

	def index
		@poem = Poem.find(params[:poem_id])
		authorize(@poem, :show?)
		render layout: 'application', locals: { model: @poem }
	end

	def new
		@commentary = Commentary.new
	end

	def create
		@commentary = Commentary.new(commentary_params)
		if @commentary.save
			redirect_to user_poem_commentaries_path(@commentary.poem_author, @commentary.poem)
		else
			render :new
		end
	end

	def edit
		@commentary = Commentary.find(params[:id])
	end

	def update
		@commentary = Commentary.find(params[:id])
		if @commentary.update(commentary_params)
			redirect_to user_poem_commentaries_path(@commentary.poem_author, @commentary.poem)
		else
			render :edit
		end
	end

private

	def commentary_params
		params.require(:commentary).permit(:comment, :commentator_id, :poem_id)
	end

end
