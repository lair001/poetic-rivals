def fake_title
	Faker::Lorem.sentence.chomp(".").titleize
end

def fake_username
	return unique_value(-> { Faker::Internet.user_name }, User, :username )
end

def fake_two_paragraphs
	Faker::Lorem.paragraphs(2).join("\n\n")
end

def fake_password
	Faker::Internet.password(Devise.password_length.min, Devise.password_length.max)
end

def fake_email
	return unique_value(-> { Faker::Internet.safe_email }, User, :email )
end

def fake_genre
	return unique_value(-> { Genre.format_genre_name(Faker::Book.genre) }, Genre, :name)
end

def unique_value(value_generator_lambda, model_class, model_attribute)
	while true
		value = value_generator_lambda.()
		return value unless model_class.exists?(model_attribute => value)
	end
end