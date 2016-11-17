include FactoryGirl::Syntax::Methods

def two_paragraphs
	Faker::Lorem.paragraphs(2).join("\n\n")
end