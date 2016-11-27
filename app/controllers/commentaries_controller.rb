class CommentariesController < ApplicationController

	def index
		@poem = Poem.find(params[:poem_id])
		authorize(@poem, :show?)
		render layout: 'application', locals: { model: @poem }
	end

	def new
		@commentary = Commentary.new(poem_id: params[:poem_id])
		authorize(@commentary)
	end

	def create
		@commentary = Commentary.new(commentary_params)
		authorize(@commentary)
		if @commentary.save
			redirect_to user_poem_commentaries_path(@commentary.poem_author, @commentary.poem)
		else
			render :new
		end
	end

	def edit
		@commentary = Commentary.find(params[:id])
		authorize(@commentary)
	end

	def update
		@commentary = Commentary.find(params[:id])
		authorize(@commentary)
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
