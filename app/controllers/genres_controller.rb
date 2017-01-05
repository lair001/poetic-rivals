class GenresController < ApplicationController

	def show
		find_genre_by_params_id
		authorize @genre
		respond_to do |f|
			f.html { render layout: 'application', locals: { model: @genre } }
			f.json { render json: @genre }
		end
	end

	def index
		sort_genres_by_name_and_paginate
	end

end
