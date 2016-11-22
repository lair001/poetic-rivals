module FakerSpecHelper
	module Generators

		def fake_title
			Faker::Lorem.sentence.chomp(".").titleize
		end

		def fake_username
			return unique_value(-> { Faker::Internet.user_name }, User, :username )
		end

		def fake_two_paragraphs
			fake_n_paragraphs(2)
		end

		def fake_n_paragraphs(n)
			Faker::Lorem.paragraphs(n).join("\n\n")
		end

		def fake_password
			Faker::Internet.password(Devise.password_length.min, Devise.password_length.max)
		end

		def fake_email
			return unique_value(-> { Faker::Internet.safe_email }, User, :email )
		end

		def fake_genre
			return unique_value(-> { Genre.format_name(POETRY_GENRES[rand(0..POETRY_GENRES.length-1)]) }, Genre, :name)
		end

		def unique_value(value_generator_lambda, model_class, model_attribute)
			while true
				value = value_generator_lambda.()
				return value unless model_class.exists?(model_attribute => value)
			end
		end

		POETRY_GENRES = [
			"20th-century lyric",
			"Aisling",
			"Akhyana",
			"Alba",
			"Anagrammatic",
			"Bayati",
			"Bertsolaritza",
			"Biker",
			"Buddhist",
			"Cadae",
			"Canso",
			"Cento",
			"Chandas",
			"Classical Chinese",
			"Clerihew",
			"Conversation",
			"Country",
			"Crambo",
			"Death",
			"Doggerel",
			"Double",
			"Dramatic",
			"Dub",
			"Eclogue",
			"Ecopoetry",
			"Elegy",
			"Epic",
			"Epigram",
			"Epistolary",
			"Epithalamium",
			"Erasure",
			"Fagu",
			"Filk",
			"Flyting",
			"Found",
			"Gab",
			"Gnomic",
			"Graphic",
			"Grook",
			"Idyll",
			"Jazz",
			"Jeremiad",
			"Lament",
			"Leonine",
			"Libel",
			"Light",
			"Long",
			"Lyric",
			"Marwysgafn",
			"McWhirtle",
			"Meditative",
			"Micropoetry",
			"Mock-heroic",
			"Monody",
			"Monologue",
			"Mutu",
			"Narrative",
			"Nonsense",
			"Nursery rhyme",
			"Obituary",
			"Parnassianism",
			"Pastoral elegy",
			"Performance poetry",
			"Poetic journal",
			"Poetical testament",
			"Political poetry",
			"Proletarian poetry",
			"Prose poetry",
			"Renga",
			"Rhymed",
			"Rhyming",
			"Conceptual",
			"Flarf",
			"Scifaiku",
			"Seguidilla",
			"Songs of realization",
			"Sound",
			"Spam",
			"Speculative",
			"Spoken",
			"Tetractys",
			"Threnody",
			"Topographical",
			"Verse drama",
			"Dramatic verse",
			"Verse",
			"Vitalist",
			"Vocabularyclept",
			"War",
			"Wisdom",
			"Xenia epigram"
		]

	end
end
