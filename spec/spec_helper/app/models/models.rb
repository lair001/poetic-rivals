def build_poems_for(model, number_of_poems, number_of_upvotes_per_poem = nil, number_of_downvotes_per_poem = nil)
	(1..number_of_poems).to_a.collect do
		poem = model.poems.build(attributes_for :poem)
		if number_of_upvotes_per_poem || number_of_downvotes_per_poem
			create_poem_voters_for_poem(poem, number_of_upvotes_per_poem, number_of_downvotes_per_poem)
		end
		poem
	end
end