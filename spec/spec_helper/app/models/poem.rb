def create_poem_voters_for_poem(poem, number_of_upvotes = nil, number_of_downvotes = nil)
	poem_voters = []
	if number_of_upvotes
		number_of_upvotes.times do
			poem_voters << create(:poem_voter, :up, poem: poem)
		end
	end
	if number_of_downvotes
		number_of_downvotes.times do
			poem_voters << create(:poem_voter, :down, poem: poem)
		end
	end
	poem_voters
end