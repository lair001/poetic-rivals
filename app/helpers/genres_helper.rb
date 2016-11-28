module GenresHelper

	def find_genre_by_params_id
		@genre = Genre.find(params[:id])
	end

	def sort_genres_by_name
		@genres = Genre.ordered_by_ascending_name
	end

end
