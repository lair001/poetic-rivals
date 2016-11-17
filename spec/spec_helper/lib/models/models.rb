def generate_poems_for(model, number_of_poems)
	number_of_poems.times do
		model.poems.build(attributes_for :poem)
	end
end