class AuthorsController < ApplicationController

	def index
		if params.has_key?(:genre_id)
			@genre = Genre.find(params[:genre_id])
			sort_genre_authors_by_score
			render layout: 'application', locals: { model: @genre }
		else
			@users = User.all
		end
	end

end