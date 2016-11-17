def fake_title
	Faker::Lorem.sentence.chomp(".").titleize
end

def fake_username
	Faker::Internet.user_name
end

def fake_two_paragraphs
	Faker::Lorem.paragraphs(2).join("\n\n")
end

def fake_password
	Faker::Internet.password(Devise.password_length.min, Devise.password_length.max)
end

def fake_email
	Faker::Internet.safe_email
end

def fake_genre
	Faker::Book.genre
end