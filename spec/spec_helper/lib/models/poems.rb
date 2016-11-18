def generate_votes_for_poem(poem, number_of_upvotes = nil, number_of_downvotes = nil)
	if number_of_upvotes
		number_of_upvotes.times do
			poem.poem_votes.build(value: 1)
		end
	end
	if number_of_downvotes
		number_of_downvotes.times do
			poem.poem_votes.build(value: -1)
		end
	end
end