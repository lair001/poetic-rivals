def generate_poems_for(model, number_of_poems, number_of_upvotes_per_poem = nil, number_of_downvotes_per_poem = nil)

	number_of_poems.times do
		generate_votes_for_poem(model.poems.build(attributes_for :poem), number_of_upvotes_per_poem, number_of_downvotes_per_poem)
	end

end