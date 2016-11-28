class CommentariesController < ApplicationController

	def index
		@poem = Poem.find(params[:poem_id])
		authorize(@poem, :show?)
		render layout: 'application', locals: { model: @poem }
	end

	def new
		@commentary = Commentary.new(commentator_id: current_user.id, poem_id: params[:poem_id])
		authorize(@commentary)
		render layout: 'application', locals: { model: @commentary }
	end

	def create
		@commentary = Commentary.new(commentary_params(:comment, :commentator_id, :poem_id))
		authorize(@commentary)
		if @commentary.save
			redirect_to user_poem_commentaries_path(@commentary.poem_author, @commentary.poem)
		else
			@current_path_name = "new_user_poem_commentary" # need to manually set this for the title block to display
			render :new, layout: 'application', locals: { model: @commentary }
		end
	end

	def edit
		@commentary = Commentary.find(params[:id])
		authorize(@commentary)
		render layout: 'application', locals: { model: @commentary }
	end

	def update
		@commentary = Commentary.find(params[:id])
		authorize(@commentary)
		if @commentary.update(commentary_params(:comment))
			redirect_to user_poem_commentaries_path(@commentary.poem_author, @commentary.poem)
		else
			@current_path_name = "edit_user_poem_commentary" # need to manually set this for the title block to display
			render :edit, layout: 'application', locals: { model: @commentary }
		end
	end

	def destroy
		@commentary = Commentary.find(params[:id])
		authorize(@commentary)
		@commentary.destroy
		redirect_to previous_path_or_root
	end

private

	def commentary_params(*args)
		params.require(:commentary).permit(*args)
		# params.require(:commentary).permit(:comment, :commentator_id, :poem_id)
	end

end
