module PagesHelper

	module Titles

		def project_title
			"Poetic Rivals"
		end

		def root_page_title
			"Poetic Rivals"
		end

		def aqm_page_title
			"The Amazing Quote Machine"
		end

		def leaderboard_users_page_title
			"Leaderboard"
		end

		def user_page_title(user)
			user.username
		end

		def new_user_session_page_title
			"Log in"
		end

		def new_user_registration_page_title
			"Sign up"
		end

		def new_user_password_page_title
			"Forgot your passord?"
		end

		def edit_user_registration_page_title
			"Update Account"
		end

		def edit_admin_user_page_title(user = nil)
			if user
				"Editing #{user.username}"
			else
				"Editing User"
			end
		end

	end

end