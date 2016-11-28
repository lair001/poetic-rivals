class GenresController < ApplicationController

	def show
		@genre = Genre.find(params[:id])
		authorize @genre
	end

	def index

	end

end
