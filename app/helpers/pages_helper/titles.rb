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

		def users_page_title
			"Directory"
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

		def user_poems_page_title
			"Poems"
		end

		def user_poem_page_title(poem)
			poem.title
		end

		def user_poem_commentaries_page_title
			"Commentaries Regarding"
		end

		def genre_page_title(genre)
			genre.name
		end

		def genre_poems_page_title
			"Poems Classified As"
		end

		def genre_authors_page_title
			"Authors Who Write Poems Classifed As"
		end

		def genres_page_title
			"Genres"
		end

		def new_user_poem_commentary_page_title
			"Commenting On"
		end

		def edit_user_poem_commentary_page_title
			"Editing Commentary Regarding"
		end

		def new_admin_genre_page_title
			"Creating a New Genre"
		end

		def edit_admin_genre_page_title(genre)
			"Editing #{genre.name}"
		end

		def new_user_poem_page_title
			"New Poem"
		end

		def edit_user_poem_page_title(poem)
			"Editing #{poem.title}"
		end

	end

end