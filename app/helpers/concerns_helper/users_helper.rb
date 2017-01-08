module ConcernsHelper
	module UsersHelper

		def display_role_for(user)
			user.role.capitalize
		end

		def sort_users_by_score
			@users ||= User.ordered_by_descending_score
		end

		def sort_users_by_username
			@users ||= User.ordered_by_ascending_username
		end

		def sort_users_by_username_and_paginate
			@users ||= User.ordered_by_ascending_username.page(params[:page])
		end

		def user_with_highest_score
			@user_with_highest_score ||= User.with_highest_score
		end

		def username_with_highest_score
			user_with_highest_score.username
		end

		def highest_score
			user_with_highest_score.score
		end

		def user_with_lowest_score
			@user_with_lowest_score ||= User.with_lowest_score
		end

		def username_with_lowest_score
			user_with_lowest_score.username
		end

		def lowest_score
			user_with_lowest_score.score
		end

		def user_with_most_fans
			@user_with_most_fans ||= User.with_most_fans
		end

		def highest_fan_count
			user_with_most_fans.fans_count
		end

		def username_with_most_fans
			user_with_most_fans.username
		end

		def user_with_most_idols
			@user_with_most_idols ||= User.with_most_idols
		end

		def highest_idol_count
			user_with_most_idols.idols_count
		end

		def username_with_most_idols
			user_with_most_idols.username
		end

		def user_with_most_rivals
			@user_with_most_rivals ||= User.with_most_rivals
		end

		def highest_rival_count
			user_with_most_rivals.rivals_count
		end

		def username_with_most_rivals
			user_with_most_rivals.username
		end

		def user_with_most_victims
			@user_with_most_victims ||= User.with_most_victims
		end

		def highest_victim_count
			user_with_most_victims.victims_count
		end

		def username_with_most_victims
			user_with_most_victims.username
		end

	end
end