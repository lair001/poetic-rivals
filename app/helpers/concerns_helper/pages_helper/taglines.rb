module ConcernsHelper

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

			def users_page_tagline
				"Discover new idols and victims!"
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

			def edit_admin_user_page_tagline(model = nil)
				"Aren't admininstrators helpful?"
			end

			def user_poems_page_tagline(user)
				link_to "By #{user.username}", user_path(user)
			end

			def user_poem_page_tagline(poem)
				link_to "By #{poem.author_username}", user_path(poem.author)
			end

			def user_poem_commentaries_page_tagline(poem)
				"#{link_to poem.title, user_poem_path(poem.author, poem)}<br>#{link_to "By #{poem.author_username}", user_path(poem.author)}"
			end

			def genre_page_tagline(genre)
				genre.status
			end

			def genre_poems_page_tagline(genre)
				link_to genre.name, genre_path(genre)
			end

			def genre_authors_page_tagline(genre)
				link_to genre.name, genre_path(genre)
			end

			def genres_page_tagline
				"At least it isn't Klingon"
			end

			def new_user_poem_commentary_page_tagline(commentary)
				"#{link_to commentary.poem_title, user_poem_path(commentary.poem_author, commentary.poem)}<br> #{link_to "By #{commentary.poem_author_username}", user_path(commentary.poem_author)}"
			end

			def edit_user_poem_commentary_page_tagline(commentary)
				"#{link_to commentary.poem_title, user_poem_path(commentary.poem_author, commentary.poem)}<br> #{link_to "By #{commentary.poem_author_username}", user_path(commentary.poem_author)}"
			end

			def new_admin_genre_page_tagline
				"By popular demand"
			end

			def edit_admin_genre_page_tagline(genre)
				genre.status
			end

			def new_user_poem_page_tagline
				"The spirit moves you to write your latest masterpiece . . ."
			end

			def edit_user_poem_page_tagline(poem)
				"#{link_to("By #{poem.author_username}", user_path(poem.author))}"
			end

		end

	end

end