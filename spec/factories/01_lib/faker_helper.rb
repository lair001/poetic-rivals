def fake_title
	Faker::Lorem.sentence.chomp(".").titleize
end

def fake_username
	while true
		username = Faker::Internet.user_name
		return username unless User.exists?(username: username)
	end
end

def fake_two_paragraphs
	Faker::Lorem.paragraphs(2).join("\n\n")
end

def fake_password
	Faker::Internet.password(Devise.password_length.min, Devise.password_length.max)
end

def fake_email
	while true
		email = Faker::Internet.safe_email
		return email unless User.exists?(email: email)
	end
end

def fake_genre
	while true
		genre = Genre.format_genre_name(Faker::Book.genre)
		return genre unless Genre.exists?(name: genre)
	end
end