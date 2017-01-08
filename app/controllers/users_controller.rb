class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		render layout: 'application', locals: { model: @user }
	end

	def index
		if current_page?(users_path)
			sort_users_by_username_and_paginate
		elsif current_page?(genre_authors_path)
			if params.has_key?(:genre_id)
				@genre = Genre.find(params[:genre_id])
				sort_genre_authors_by_score
				render layout: 'application', locals: { model: @genre }
			else
				@users = User.all
			end
		end
	end

end