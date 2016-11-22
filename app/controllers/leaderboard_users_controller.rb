class LeaderboardUsersController < ApplicationController

	def index
		sort_users_by_score
	end

end