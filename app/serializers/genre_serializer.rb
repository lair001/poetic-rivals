class GenreSerializer < ApplicationSerializer

	attributes :id, :name, :poems_count, :authors_count, :show_page_title, :show_page_tagline

	def show_page_title
		view_context.genre_page_title(object)
	end

	def show_page_tagline
		view_context.genre_page_tagline(object)
	end

end
