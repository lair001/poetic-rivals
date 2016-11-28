class Admin::GenresController < Admin::ApplicationController

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(admin_genre_params)
		if @genre.save
			redirect_to genre_path(@genre)
		else
			@current_path_name = "new_admin_genre" # need to manually set this for the title block to display
			render :new
		end
	end

	def update
		find_genre_by_params_id
		if @genre.update(admin_genre_params)
			redirect_to genre_path(@genre)
		else
			@current_path_name = "edit_admin_genre" # need to manually set this for the title block to display
			render :edit, layout: 'application', locals: { model: @genre }
		end

	end

	def edit
		find_genre_by_params_id
		render layout: 'application', locals: { model: @genre }
	end

private

	def admin_genre_params
		params.require(:genre).permit(:name, :banned)
	end

end