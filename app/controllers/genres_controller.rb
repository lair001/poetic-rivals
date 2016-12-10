class GenresController < ApplicationController

	def show
		find_genre_by_params_id
		authorize @genre
		render layout: 'application', locals: { model: @genre }
	end

	def index
		sort_genres_by_name_and_paginate
	end

end
