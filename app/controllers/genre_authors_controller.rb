class GenreAuthorsController < ApplicationController

	def index
		@genre = Genre.find(params[:genre_id])
		authorize @genre, :show?
		params[:excluded_ids] ? excluded_ids = params[:excluded_ids].split(',') : excluded_ids = []
		@users = @genre.authors_ordered_by_descending_score.page(1).where.not(id: excluded_ids)
		respond_to do |f|
			f.html do
				excluded_ids = @users.collect{ |user| user.id.to_s }.join(',')
				render 'users/index', layout: 'application', locals: { model: @genre, page_data: { excluded_ids: excluded_ids } }
			end
			f.json { @users.count > 0 ? render(json: @users, fields: [:id, :username, :role, :created_at_date, :created_at_time, :score, :rounded_score_per_poem]) : render_record_not_found_json }
		end
	end

end