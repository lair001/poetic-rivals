class GenresController < ApplicationController

	def show
		respond_to do |f|
			f.html do
				find_genre_by_params_id
				authorize @genre
				render layout: 'application', locals: { model: @genre, page_data: { genres_count: policy_scope(Genre).count, sort_position: params[:sort_position] } }
			end
			f.json do
				# when requesting JSON, params[:id] corresponds to sort_position
				@genre = policy_scope(Genre.ordered_by_ascending_name).page(params[:id]).per(1).first
				render json: @genre, fields: [:id, :poems_count, :authors_count, :show_page_title, :show_page_tagline]
			end
		end
	end

	def index
		sort_genres_by_name_and_paginate
	end

end
