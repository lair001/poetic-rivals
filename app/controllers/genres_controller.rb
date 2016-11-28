class GenresController < ApplicationController

	def show
		find_genre_by_params_id
		authorize @genre
	end

	def index
		sort_genres_by_name
	end

end
