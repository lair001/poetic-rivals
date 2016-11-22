module PagesHelper

	module Taglines

		def root_page_tagline
			"You never knew that poetry could be this brutal!"
		end

		def leaderboard_users_page_tagline
			"Vae Victis"
		end

		def user_page_tagline(user)
			display_role_for(user)
		end

		def new_user_session_page_tagline
			"Face the admiration of your fans and the scorn of your rivals!"
		end

		def new_user_registration_page_tagline
			"Vie for the admiration of countless fans!"
		end

		def new_user_password_page_tagline
			"The stress is making you senile . . ."
		end

		def edit_user_registration_page_tagline
			"It may be time to rework your image . . ."
		end

	end

end