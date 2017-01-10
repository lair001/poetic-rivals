class GenrePoemsController < ApplicationController

	def index
		@genre = Genre.find(params[:genre_id])
		sort_genre_poems_by_updated_at
		render 'poems/index', layout: 'application', locals: { model: @genre }
	end

end