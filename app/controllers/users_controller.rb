class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		render layout: 'application', locals: { model: @user }
	end

	def index
		sort_users_by_username_and_paginate
	end

end