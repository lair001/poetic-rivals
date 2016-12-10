module GenresHelper

	def find_genre_by_params_id
		@genre = Genre.find(params[:id])
	end

	def sort_genre_poems_by_updated_at
		@poems = policy_scope(@genre.poems_ordered_by_descending_updated_at)
	end

	def sort_genre_authors_by_score
		@users = @genre.authors_ordered_by_descending_score
	end

	def sort_genres_by_name
		@genres = policy_scope(Genre.ordered_by_ascending_name)
	end

	def sort_genres_by_name_and_paginate
		@genres = policy_scope(Genre.ordered_by_ascending_name).page(params[:page])
	end

end
