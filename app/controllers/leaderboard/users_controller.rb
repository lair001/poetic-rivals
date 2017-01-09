class Leaderboard::UsersController < Leaderboard::ApplicationController

	def index
		params[:excluded_ids] ? excluded_ids = params[:excluded_ids].split(',') : excluded_ids = []
		@users = User.ordered_by_descending_score.page(1).where.not(id: excluded_ids)
		respond_to do |f|
			f.html {}
			f.json { render json: @users, fields: [:id, :username, :role, :created_at_date, :created_at_time, :score, :rounded_score_per_poem] }
		end
	end

end