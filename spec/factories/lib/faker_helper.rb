def fake_title
	Faker::Lorem.sentence.chomp(".").titleize
end

def fake_two_paragraphs
	Faker::Lorem.paragraphs(2).join("\n\n")
end