class GenrePoemsController < ApplicationController

	def index
		@genre = Genre.find(params[:genre_id])
		authorize @genre, :show?
		params[:excluded_ids] ? excluded_ids = params[:excluded_ids].split(',') : excluded_ids = []
		@poems = policy_scope(@genre.poems_ordered_by_descending_updated_at).where.not(id: excluded_ids).limit(Kaminari.config.default_per_page)
		respond_to do |f|
			f.html do
				excluded_ids = @poems.collect{ |poem| poem.id.to_s }.join(',')
				render 'poems/index', layout: 'application', locals: { model: @genre, page_data: { excluded_ids: excluded_ids, genre_id: params[:genre_id] } }
			end
			f.json { @poems.count > 0 ? render(json: @poems, fields: [:id, :title, :genres_list, :created_at_date, :created_at_time, :updated_at_date, :updated_at_time]) : render_record_not_found_json }
		end
	end

end