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

	def new
		@poem = Poem.new(author_id: current_user.id)
	end

	def create
		@poem = Poem.new(poem_params(:author_id))
		authorize(@poem)
		if @poem.save
			redirect_to user_poem_path(@poem)
		else
			@current_path_name = "new_user_poem"
			render :new
		end
	end

	def edit
		@poem = Poem.find(params[:id])
		authorize(@poem)
		render layout: 'application', locals: { model: @poem }
	end

	def update
		@poem = Poem.find(params[:id])
		authorize(@poem)
		if @poem.update(poem_params)
			redirect_to user_poem_path(@poem.author, @poem)
		else
			@current_path_name = "edit_user_poem"
			render :edit, layout: 'application', locals: { model: @poem }
		end
	end

private

	def poem_params(*args)
		params.requre(:poem).permit(*args, :title, :body, :private, genre_ids: [], genres_attributes: [:name])
	end

end
